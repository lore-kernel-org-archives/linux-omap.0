From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [RFC v2][PATCH 1/7] OMAP: DSS2: Overlay Manager LCD2 changes in
 dispay.h
Date: Wed, 14 Jul 2010 13:21:07 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305CE55E8@dbde02.ent.ti.com>
References: <1279089167-14057-1-git-send-email-archit@ti.com>
 <1279089167-14057-2-git-send-email-archit@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7AADFB3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45501 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab0GNHvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jul 2010 03:51:14 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7AADFB3@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

Hi,

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Taneja, Archit
> > Sent: Wednesday, July 14, 2010 12:03 PM
> > To: tomi.valkeinen@nokia.com
> > Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Guruswamy, 
> > Senthilvadivu; Mittal, Mukund; Taneja, Archit; Nilofer, Samreen
> > Subject: [RFC v2][PATCH 1/7] OMAP: DSS2: Overlay Manager 
> LCD2 changes 
> > in dispay.h
> > 
> > From: Sumit Semwal <sumit.semwal@ti.com>
> > 
> > Overlay Manager LCD2 changes in dispay.h
> > 
> > Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > Signed-off-by: Mukund Mittal <mmittal@ti.com>
> > Signed-off-by: Archit Taneja <archit@ti.com>
> > Signed-off-by: Samreen <samreen@ti.com>
> > ---
> 
> [sp] Do these changes really have to be in a separate patch?
>      Wouldn't it be better to combine them logically with
>      the usage?
> 
> ~sanjeev
> 
The introduction of the secondary channel causes many changes
across different files, patches 1, 2, 4, 5, 7 introduces this
feature and splits it both logically and on the basis of files
modified.
One of the main reason to introduce one single patch for display.h
is because it is central to DSS2 and one glance at it tells how
the other files will be affected.

For example, if in a future patch we need to introduce another video
pipeline, the file display.h will introduce the new enum member.

Thanks,

Archit