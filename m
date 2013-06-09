From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 device tree conversion: how to do first step
Date: Sun, 9 Jun 2013 18:47:45 +0200
Message-ID: <20130609164745.GB16066@amd.pavel.ucw.cz>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <201306091124.41251@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201306091124.41251@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, lauri.leukkunen@nokia.com
List-Id: linux-omap@vger.kernel.org

On Sun 2013-06-09 11:24:40, Pali Roh=E1r wrote:
> On Sunday 09 June 2013 03:59:44 Pavel Machek wrote:
> > Hi!
> >=20
> > I'd like to convert Nokia N900 to device tree.
> >=20
> > Unfortunately, serial port is not easily available (very
> > special cable would be needed, does someone know where to get
> > one?) and I don't have BDI (and very special cable would be
> > needed, too).
> >=20
>=20
> Hello,
>=20
> I used serial port only in qemu for debugging. Maybe you can try
> to play with qemu first. Qemu has good n900 HW support.

Yes, qemu is helpful.

=46or the record: this is how you use it.

KERNEL=3D/data/l/linux-n900/zImage_dtb
=2E/qflasher -m rx51 -x ./xloader-qemu.bin -s ./secondary-qemu.bin -k $=
KERNEL -o n900.img -p k=3D6072

> sd-empty
=2E/qemu-system-arm -s -M n900 -mtdblock n900.img -sd sd-empty -serial
stdio -clock unix -redir tcp:5555:10.0.2.15:22

=2E..and this patch is needed to make it past rx51_init.

Author: Pavel <pavel@ucw.cz>
Date:   Sun Jun 9 18:45:39 2013 +0200

    Comment out errata workaround that breaks qemu.

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
index 938e46f..0ffd7d3 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -108,11 +108,13 @@ static void __init rx51_init(void)
 	rx51_peripherals_init();
 	rx51_camera_init();
=20
+#if 0
 #ifdef CONFIG_ARM_ERRATA_430973
 	printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\n");
 	/* set IBE to 1 */
 	rx51_secure_update_aux_cr(1 << 6, 0);
 #endif
+#endif
=20
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
