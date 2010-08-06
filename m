From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: omap3camera and linux-omap
Date: Fri, 6 Aug 2010 10:32:36 -0500
Message-ID: <A24693684029E5489D1D202277BE894456DF59A3@dlee02.ent.ti.com>
References: <4C5C129A.3020808@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53309 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab0HFPcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 11:32:51 -0400
In-Reply-To: <4C5C129A.3020808@matrix-vision.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>

Hi Michael,


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Michael Jones
> Sent: Friday, August 06, 2010 8:48 AM
> To: linux-omap@vger.kernel.org
> Cc: sakari.ailus@maxwell.research.nokia.com
> Subject: omap3camera and linux-omap
> 
> I am currently using Sakari's omap3camera repository (branch 'devel').
> 'git merge-base linux-omap omap3camera' tells me that the last commit
> omap3camera has in common with linux-omap is 40a0c47, from July 7 2010.
> But there are >1000 commits which are only in omap3camera, dating back to
> 2008.
> 
> Is this destined to stay this way?

This is because devel branch keeps a detailed development history since we started working on the camera driver. At the end, the patches submitted will be a consolidated set, which should end in something around ~12 patches or so..

> Or will the omap3camera tree be merged into linux-omap at some point?

The omap3camera submission is on hold, because the camera driver is dependant on Media controller framework, which is holding for merge in linux-media mailing list.

> 
> When proposing a patch for the omap3camera tree, should it be sent to this
> list?

You should preferably send the patches to linux-media (at) vger.kernel.org mailing with cc to Sakari Ailus and Laurent Pinchart.

So far we have been keeping patch review internally, because we didn't want to pollute the mailing list with patches to unsubmitted code.

Regards,
Sergio

> 
> Thanks,
> Michael
> 
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-
> Joachim Reich
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
