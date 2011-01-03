From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Cannot get USB ports on custom beagleboard to work
Date: Mon, 3 Jan 2011 19:56:58 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024816D6F2@dbde02.ent.ti.com>
References: <CD7E5510-23E4-4014-AB49-C1914F11D043@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46762 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847Ab1ACO1G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 09:27:06 -0500
In-Reply-To: <CD7E5510-23E4-4014-AB49-C1914F11D043@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Elvis Dowson
> Sent: Monday, January 03, 2011 4:07 AM
> To: linux-omap Mailing List
> Subject: Cannot get USB ports on custom beagleboard to work
> 
> Hi,
>        I have a custom beagleboard on which I cannot seem to 
> get the USB ports to work with a wired mouse, using a powered USB hub.
> 
> Any suggestions on how I can trouble shoot this issue. This 
> is based off the TI rowboat-eclair-2.6.32 kernel.
>
[snip]...[snip]

> Starting udev
> Remounting root file system...
> Caching udev devnodes
> Populating dev cache
> logger: mount: mount point /proc/bus/usb does not exist

I not familiar with the Android kernels, but based on this error:
Check that "CONFIG_USB_DEVICEFS=y" in your kernel configuration.

~sanjeev

[snip]...[snip]
