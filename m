From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: Linux-next as of 20110222 broken on OMAP4
Date: Tue, 22 Feb 2011 15:58:05 +0530
Message-ID: <f2bd6483c7999508b05c2d00a0e45c3b@mail.gmail.com>
References: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com> <AANLkTikD6ntKWBXRtgPcpkApKkZrnvG8qK1qYEDrdob5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49522 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753556Ab1BVK2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 05:28:07 -0500
Received: by mail-fx0-f41.google.com with SMTP id 5so2430579fxm.28
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 02:28:06 -0800 (PST)
In-Reply-To: <AANLkTikD6ntKWBXRtgPcpkApKkZrnvG8qK1qYEDrdob5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Govindraj wrote:
> On Tue, Feb 22, 2011 at 3:19 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> > Looks like linux-next as of today is broken on at least OMAP4.
> >
> > Turning on earlyprintk, I get a crash in omap_init_mcspi. Disabling
> > CONFIG_SPI_OMAP24XX gets me as far as the following lines from my
> > bootup log, but I haven't attempted to debug further.
>
>
> SPI fix is available but yet be merged its discussed in this thread:
>
> http://dchs.spinics.net/lists/linux-omap/msg46446.html

And the other hack I needed to fix the failure when I disable SPI
is this one (thanks Tarun).

It's just a hack - I hope a better fix will be along shortly.

- Anand

Index: linux-omap-usb/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
===================================================================
--- linux-omap-usb.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ linux-omap-usb/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5068,7 +5068,7 @@ static __initdata struct omap_hwmod *oma
 	&omap44xx_spinlock_hwmod,

 	/* timer class */
-	&omap44xx_timer1_hwmod,
+	/* &omap44xx_timer1_hwmod, */
 	&omap44xx_timer2_hwmod,
 	&omap44xx_timer3_hwmod,
 	&omap44xx_timer4_hwmod,
