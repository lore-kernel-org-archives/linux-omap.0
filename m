From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: Suspend/Resume Broken on AM43/AM33 Platforms
Date: Sun, 18 Aug 2019 23:27:27 -0700
Message-ID: <5d5a4150.1c69fb81.3faa2.eee8@mx.google.com>
References: <49fc7c64-88c0-74d0-2cb3-07986490941d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <49fc7c64-88c0-74d0-2cb3-07986490941d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, herbert@gondor.apana.org.au
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Quoting Keerthy (2019-08-18 21:24:58)
> Hi Stephen,
>=20
> commit 03a3bb7ae63150230c5de645dc95e673ebf17e1a
> Author: Stephen Boyd <swboyd@chromium.org>
> Date:   Mon Aug 5 16:32:41 2019 -0700
>=20
>      hwrng: core - Freeze khwrng thread during suspend
>=20
> Commit seems to be breaking suspend/resume on TI AM43/AM33 platforms.
>=20
>=20
> rtcwake: wakeup from "mem" using /dev/rtc0 at Sun Nov 18 02:12:12 2018
> [   54.033833] PM: suspend entry (deep)
> [   54.037741] Filesystems sync: 0.000 seconds
> [   54.062730] Freezing user space processes ... (elapsed 0.001 seconds) =

> done.
> [   54.071313] OOM killer disabled.
> [   54.074572] Freezing remaining freezable tasks ...
> [   74.083121] Freezing of tasks failed after 20.003 seconds (1 tasks=20
> refusing to freeze, wq_busy=3D0):
> [   74.092257] hwrng           R  running task        0   289      2=20
> 0x00000020
> [   74.099511] [<c08c64c4>] (__schedule) from [<c08c6a10>]=20
> (schedule+0x3c/0xc0)
> [   74.106720] [<c08c6a10>] (schedule) from [<c05dbd8c>]=20
> (add_hwgenerator_randomness+0xb0/0x100)
> [   74.115358] [<c05dbd8c>] (add_hwgenerator_randomness) from=20
> [<bf1803c8>] (hwrng_fillfn+0xc0/0x14c [rng_core])

Thanks for the report. I suspect we need to check for freezer in
add_hwgenerator_randomness(). I find it odd that there's another caller
of add_hwgenerator_randomness(), but maybe the ath9k driver can be
converted to some sort of hwrng driver instead of calling into the
kthread directly.

Anyway, can you try this patch?

---8<---
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..e2e85ca16410 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2429,6 +2429,7 @@ void add_hwgenerator_randomness(const char *buffer, s=
ize_t count,
 				size_t entropy)
 {
 	struct entropy_store *poolp =3D &input_pool;
+	bool frozen =3D false;
=20
 	if (unlikely(crng_init =3D=3D 0)) {
 		crng_fast_load(buffer, count);
@@ -2439,9 +2440,12 @@ void add_hwgenerator_randomness(const char *buffer, =
size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait, kthread_should_stop() ||
+	wait_event_interruptible(random_write_wait,
+			kthread_freezable_should_stop(&frozen) ||
 			ENTROPY_BITS(&input_pool) <=3D random_write_wakeup_bits);
-	mix_pool_bytes(poolp, buffer, count);
-	credit_entropy_bits(poolp, entropy);
+	if (!frozen) {
+		mix_pool_bytes(poolp, buffer, count);
+		credit_entropy_bits(poolp, entropy);
+	}
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
