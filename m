From: "ananth" <ananth@lge.com>
Subject: RE: Any one has ramfs Image for OMAP1510
Date: Tue, 3 Jun 2008 16:04:41 +0530
Message-ID: <C0B486D0719F49F085FE6CA34F7D1DA5@LGE.NET>
References: <09A5BCEAD84B459FB17C941A0A345D1F@LGE.NET> <0680EC522D0CC943BC586913CF3768C001DE44669D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from LGEMRELSE3Q.lge.com ([156.147.1.113]:55369 "EHLO
	LGEMRELSE3Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbYFCKen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 06:34:43 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C001DE44669D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Syed Mohammed, Khasim'" <khasim@ti.com>, linux-omap@vger.kernel.org



-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Syed Mohammed, Khasim
Sent: Tuesday, June 03, 2008 3:36 PM
To: ananth; linux-omap@vger.kernel.org
Subject: RE: Any one has ramfs Image for OMAP1510



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ananth
> Sent: Tuesday, June 03, 2008 3:31 PM
> To: linux-omap@vger.kernel.org
> Subject: Any one has ramfs Image for OMAP1510
>
> Hi All
>
>
>
>             I am trying to boot the Linux on OMAP1510 Board. I am able to
> load the kernel after building it from Linux-2.4.19
>
>
>
>             Now I am not having the file system, and I checked the site
> http://www.wearablegroup.org/software/ramdisk, but the site itself is not
> existing.
>
>

Did you try any of these, they are bit old so might work for you.

http://linux.omap.com/pub/filesystem/


Yes, I tried this Images to load directly into flash and got the problems, 
I am in the process of using these images as NFS

Which tool chain are you using for compiling the kernel?

I built the arm-linux tool chain as mentioned in the swpa011.pdf file.

Regards,
Khasim
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

