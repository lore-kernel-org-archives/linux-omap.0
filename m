From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: Zoom3 not booting with omap3_defconfig (update: sometimes...)
Date: Mon, 9 Aug 2010 15:09:32 -0500
Message-ID: <A24693684029E5489D1D202277BE894456EA3043@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894456EA2F3F@dlee02.ent.ti.com>
 <49EAB745-5CB7-429F-8875-9EB349DC3803@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49653 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815Ab0HIUJf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 16:09:35 -0400
In-Reply-To: <49EAB745-5CB7-429F-8875-9EB349DC3803@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Elvis Dowson [mailto:elvis.dowson@mac.com]
> Sent: Monday, August 09, 2010 2:17 PM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Zoom3 not booting with omap3_defconfig
> 
> Hi Sergio,
>                      I've seen the exact same thing happen, when I used
> the linux-omap v2.6.35 tag for a beagleboard based device. It gives me the
> same kernel panic.

Actually, I realized something weird...

If I have the exact same kernel, generated with omap3_defconfig, IT sometimes generates me these errors:

> [    2.674804] IP-Config: Failed to open eth0
> [    2.678924] IP-Config: No network devices available.

And sometimes it succeeds:

> [    2.680389] net eth0: SMSC911x/921x identified at 0xe08da000, IRQ: 318
> [    3.688232] Sending DHCP requests .., OK
> [    6.469879] IP-Config: Got DHCP answer from 0.0.0.0, my address is 128.247.75.216
> [    6.479034] IP-Config: Complete:

So, I don't know... Either I have a faulty HW, or some race condition is happening on the driver that doesn't allow to open it..

I'll try to find out why the open of eth0 fails sometimes..

Regards,
Sergio

> 
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
> In my case, I found that using v2.6.35 and using the
> omap3_beagleboard_defconfig worked.
> 
> This must an artifact from the defconfig clean up that happened for
> v2.6.35, breakages due to defective or untested defconfigs.
> 
> Why don't you try a defconfig from a previous kernel version that works?
> 
> Best regards,
> 
> Elvis Dowson
