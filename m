From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 1/3] OMAP: DSS2: Zorder enum in display.h
Date: Thu, 22 Jul 2010 09:41:53 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305EEA38A@dbde02.ent.ti.com>
References: <1279541407-17711-1-git-send-email-archit@ti.com>
 <1279541407-17711-2-git-send-email-archit@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7C75F38@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649Ab0GVEL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jul 2010 00:11:59 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7C75F38@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

 

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Wednesday, July 21, 2010 7:47 PM
> To: Taneja, Archit; tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Nilofer, 
> Samreen; Taneja, Archit
> Subject: RE: [PATCH 1/3] OMAP: DSS2: Zorder enum in display.h
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Archit Taneja
> > Sent: Monday, July 19, 2010 5:40 PM
> > To: tomi.valkeinen@nokia.com
> > Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Nilofer, Samreen; 
> > Taneja, Archit
> > Subject: [PATCH 1/3] OMAP: DSS2: Zorder enum in display.h
> > 
> > From: Sumit Semwal <sumit.semwal@ti.com>
> > 
> > Add Zorder enum in display.h
> > 
> 
> Patches 1 and 2 in the series can easily be conbined into one.
> Separating few line changes in header file from 
> implementation across 2 patches isn't useful.

[archit] We are introducing a new DSS feature for OMAP4 in every
patch series. In order to clearly explain the feature introduced,
the first patch of every series makes changes on in the display.h
header which is central to the DSS2 code.

If this is not a accepted norm or a strong enough reason to have a
separate small patch, I can rework these series, I would need more
comments from others though.

<snap>

> > +enum omap_overlay_zorder {
> > +	OMAP_DSS_OVL_ZORDER_0	= 0x0,
> > +	OMAP_DSS_OVL_ZORDER_1	= 0x1,
> > +	OMAP_DSS_OVL_ZORDER_2	= 0x2,
> > +	OMAP_DSS_OVL_ZORDER_3	= 0x3,
> > +};
> 
> Is "_DSS_" really needed in these emums? considering that 
> enum itself doesn't contain "_dss_" in its name.
> 

[archit] I agree with this, but the present header is inconsistent
with the point you have made, there are other enums which don't have
"_dss_" but have "_DSS_" in its enum members. We should try to make
this uniform (unless there is a motive behind it).

> ~sanjeev
> 

Regards,

Archit
