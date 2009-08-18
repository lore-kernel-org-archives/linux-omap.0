From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: SDP support seems broken in LO
Date: Tue, 18 Aug 2009 17:53:17 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B9DCC60E@dbde02.ent.ti.com>
References: <ce9ab5790908180519t644723cbw6876901066f1f213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48733 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbZHRMXY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 08:23:24 -0400
In-Reply-To: <ce9ab5790908180519t644723cbw6876901066f1f213@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of vimal singh
> Sent: Tuesday, August 18, 2009 5:49 PM
> To: linux-omap@vger.kernel.org
> Subject: SDP support seems broken in LO
> 
> LO seems broken on OMAP3430 SDP platform. I compile latest kernel with
> 'omap_3430sdp_defconfig' config options.
> 
> Booting hangs after kernel uncompressed and last message which appears
> is 'booting the kernel'
> 
> 
> Thanks and regards,
> vimal
> 
> See below log:
> 
> ## Booting image at 80000000 ...
>    Image Name:   Linux-2.6.31-rc5-omap1-05896-ge0
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2520992 Bytes =  2.4 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing
> Linux.....................................................................
> ..........................................................................
> ..................
> done, booting the kernel.
Mainly because of frame-buffer and musb. You can try disabling these two and see if it boots.


Regards,
Santosh
