From: deepthi <deepthi_kiran@mindtree.com>
Subject: Re: ZOOM2 doesn't boot on upstream kernel
Date: Fri, 16 Dec 2011 07:33:37 +0000 (UTC)
Message-ID: <loom.20111216T082358-46@post.gmane.org>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com> <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com> <A24693684029E5489D1D202277BE894456224D59@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54825 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab1LPHfI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:35:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RbSJu-0002pd-GC
	for linux-omap@vger.kernel.org; Fri, 16 Dec 2011 08:35:06 +0100
Received: from 112.121.55.9 ([112.121.55.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 08:35:06 +0100
Received: from deepthi_kiran by 112.121.55.9 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 08:35:06 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi,

We are trying to boot 35 kernel on zoom2,I tried with android_zoom3 config and
choosing MACH as zoom2 and also with omap_zoom2_defconfig, kernel is not booting
at all,it is struck after 
Starting kernel ...

Uncompressing Linux...
 done, booting the kernel.

I have taken the omap4 panda release kernel for gingerbread.
Image name it is showing as Linux-2.6.35.7-00371-gcfb80c7-di

Please let me know Which kernel we have to take for zoom2 35.
I have tried with following bootargs
setenv bootargs console=ttyS3,115200n8 mem=256M  root=/dev/mmcblk0p2 rootdelay=1
init=/init omap_vout.video1_numbuffers=6 omap_vout.vid1_static_vrfb_alloc=y
omapfb.vram=0:4M
I even tried with ttyO3 also.
What should be the exact console should it be ttyO0?
Please help me out to come out from this issue





