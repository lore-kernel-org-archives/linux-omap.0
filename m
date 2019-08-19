From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: Suspend/Resume Broken on AM43/AM33 Platforms
Date: Mon, 19 Aug 2019 08:00:24 -0700
Message-ID: <5d5ab989.1c69fb81.6c07e.bcce@mx.google.com>
References: <49fc7c64-88c0-74d0-2cb3-07986490941d@ti.com> <5d5a4150.1c69fb81.3faa2.eee8@mx.google.com> <b0678bfc-05ae-99b4-5b24-5c813efe718d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0678bfc-05ae-99b4-5b24-5c813efe718d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, herbert@gondor.apana.org.au
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Quoting Keerthy (2019-08-19 00:27:13)
>=20
>=20
> On 19/08/19 11:57 AM, Stephen Boyd wrote:
> > Quoting Keerthy (2019-08-18 21:24:58)
> >> Hi Stephen,
> >>
> >> commit 03a3bb7ae63150230c5de645dc95e673ebf17e1a
> >> Author: Stephen Boyd <swboyd@chromium.org>
> >> Date:   Mon Aug 5 16:32:41 2019 -0700
> >>
> >>       hwrng: core - Freeze khwrng thread during suspend
> >>
> >> Commit seems to be breaking suspend/resume on TI AM43/AM33 platforms.
> >>
> >>
> >> rtcwake: wakeup from "mem" using /dev/rtc0 at Sun Nov 18 02:12:12 2018
> >> [   54.033833] PM: suspend entry (deep)
> >> [   54.037741] Filesystems sync: 0.000 seconds
> >> [   54.062730] Freezing user space processes ... (elapsed 0.001 second=
s)
> >> done.
> >> [   54.071313] OOM killer disabled.
> >> [   54.074572] Freezing remaining freezable tasks ...
> >> [   74.083121] Freezing of tasks failed after 20.003 seconds (1 tasks
> >> refusing to freeze, wq_busy=3D0):
> >> [   74.092257] hwrng           R  running task        0   289      2
> >> 0x00000020
> >> [   74.099511] [<c08c64c4>] (__schedule) from [<c08c6a10>]
> >> (schedule+0x3c/0xc0)
> >> [   74.106720] [<c08c6a10>] (schedule) from [<c05dbd8c>]
> >> (add_hwgenerator_randomness+0xb0/0x100)
> >> [   74.115358] [<c05dbd8c>] (add_hwgenerator_randomness) from
> >> [<bf1803c8>] (hwrng_fillfn+0xc0/0x14c [rng_core])
> >=20
> > Thanks for the report. I suspect we need to check for freezer in
> > add_hwgenerator_randomness(). I find it odd that there's another caller
> > of add_hwgenerator_randomness(), but maybe the ath9k driver can be
> > converted to some sort of hwrng driver instead of calling into the
> > kthread directly.
> >=20
> > Anyway, can you try this patch?
>=20
> I applied the below patch on top of latest next branch.
>=20
> Fixes the issue.
>=20

Cool thanks. I'll send an official patch now.
