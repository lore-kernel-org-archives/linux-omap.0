From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DSS2 and 2.6.36
Date: Mon, 22 Nov 2010 18:19:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BC762ADB@dbde02.ent.ti.com>
References: <A1FC6DD0-C6CA-4E03-B4DD-C3AD4CCC9619@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54286 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433Ab0KVMtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 07:49:16 -0500
In-Reply-To: <A1FC6DD0-C6CA-4E03-B4DD-C3AD4CCC9619@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Grant Erickson
> Sent: Friday, November 12, 2010 11:35 PM
> To: linux-omap@vger.kernel.org
> Subject: DSS2 and 2.6.36
> 
> I have a Mistral AM37x development board and am working on transitioning
> it from the 2.6.32 provided with the SDK to 2.6.36 and have run into some
> issues with the OMAP2 DSS driver that it seems others have encountered as
> well (e.g. "DSS2 broken with 36-rc1"

[Hiremath, Vaibhav] Are you using 2.6.36 stable version or 2.6.36-rcX? I would suggest you to use latest kernel, I started using 2.6.36 stable version and it is working fine for me.

Thanks,
Vaibhav

> <http://marc.info/?t=128196295000004&r=1&w=2 and "[PATCH 1/2] video: omap:
> vram: remove from normal memory"
> <http://marc.info/?t=128714705300004&r=1&w=2>).
> 
> Is 2.6.37-rcY the preferred canonical tree to fast-forward to pick up the
> remap/allocation/reserve changes for this or is there another preferred
> tree (e.g. git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-
> omap-2.6.git or git://gitorious.org/linux-omap-dss2/linux.git)?
> 
> Best,
> 
> Grant
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
