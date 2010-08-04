From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: Unable to load ext3 partition from mmc card
Date: Wed, 4 Aug 2010 11:11:45 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E5E4492@dbde02.ent.ti.com>
References: <45FFBB97-C823-4C41-9D09-48895A4ECE8B@mac.com>
 <BA49A8F9-B682-49D0-8B9F-1AD5D7ABB8CA@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49059 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab0HDFlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 01:41:52 -0400
In-Reply-To: <BA49A8F9-B682-49D0-8B9F-1AD5D7ABB8CA@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Elvis Dowson
> Sent: Wednesday, August 04, 2010 6:25 AM
> To: linux-omap@vger.kernel.org
> Subject: Re: Unable to load ext3 partition from mmc card
> 
> 
> On Aug 4, 2010, at 3:53 AM, Elvis Dowson wrote:
> 
> > Hi,
> >       I'm trying out u-boot-2010.06 and linux-omap-2.6.34, and I'm using
> the omap3_defconfig.
> >
> > I get the following error upon boot:
> >
> > [    2.097320] Waiting for root device /dev/mmcblk0p2...
> > [    2.235595] mmc0: new SD card at address b874
> > [    2.243530] mmcblk0: mmc0:b874 SU02G 1.87 GiB (ro)
> > [    2.250213]  mmcblk0: p1 p2
> > [    2.323638] VFS: Cannot open root device "mmcblk0p2" or unknown-
> block(179,2)
> > [    2.330871] Please append a correct "root=" boot option; here are the
> available partitions:
> > [    2.339477] b300         1971712 mmcblk0 driver: mmcblk
> > [    2.344848]   b301           40131 mmcblk0p1
> > [    2.349182]   b302          514080 mmcblk0p2
> > [    2.353973] Kernel panic - not syncing: VFS: Unable to mount root fs
> on unknown-block(179,2)
> 
> I found that switching to v2.6.35 and using the
> omap3_beagleboard_defconfig, works. It doesn't work for some reason for
> v2.6.34.

[Ghorai] I used omap3_defconfig on v2.6.34 for beagleboard; here is the bootargs that works for me -
setenv bootargs 'console=ttyS2,115200n8 console=tty0 noinitrd root=/dev/mmcblk0p2 rootdelay=3'

> 
> Best regards,
> 
> Elvis Dowson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
