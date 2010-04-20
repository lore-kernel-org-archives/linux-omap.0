From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DVSDK on OMAP/3530
Date: Tue, 20 Apr 2010 13:45:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E13785A@dbde02.ent.ti.com>
References: <4BC8BA17.5060200@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40881 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab0DTIQG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 04:16:06 -0400
In-Reply-To: <4BC8BA17.5060200@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gary Thomas
> Sent: Saturday, April 17, 2010 12:57 AM
> To: OMAP Linux discussion
> Subject: DVSDK on OMAP/3530
> 
> I'm trying to run the DVSDK 3.01.00.03 on an OMAP/3530 board which is
> not the OMAP3EVM (close, but from a different manufacturer).
> I've ported my board specifics to the kernel that comes with
> the DVSDK and everything seems to work.
> 
> Except for the video demos :-(  When I try to run 'decode',
> it attempts to open the device '/dev/video1' which I've deduced
> is a display in video mode.  However, I can't figure out where
> or how that device is supposed to be created.
> 
> I've compared my kernel config with the standard EVM config
> and all of the VIDEO/DSS/FB options match.
> 
> Can someone give me some help/guidance?
[Hiremath, Vaibhav] I believe I had answered similar query from you earlier today, let me summarize it here again - 

The V4L2 device nodes will get created under /dev/videox
Where, x = 1 or 2 depending on CONFIG_FB_OMAP2_NUM_FBS.

The equation would be,

Num of V4l2 nodes = 3 - CONFIG_FB_OMAP2_NUM_FBS

And CONFIG_FB_OMAP2_NUM_FBS can not be less than 0.

Thanks,
Vaibhav

> 
> note: I'm not sure the best place to ask this - the DVSDK
> getting started guide refers to omap3530_dvevm_beta@list.ti.com
> but I cannot find it...
> 
> Thanks
> 
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
