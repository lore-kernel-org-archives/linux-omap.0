From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Thu, 7 Jan 2010 14:43:58 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703005196AC@dbde02.ent.ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
	<1258004721-7315-2-git-send-email-nm@ti.com>
	<1258004721-7315-3-git-send-email-nm@ti.com>
	<1258004721-7315-4-git-send-email-nm@ti.com>
	<1258004721-7315-5-git-send-email-nm@ti.com>
	<1258004721-7315-6-git-send-email-nm@ti.com>
	<87eimrx4em.fsf@deeprootsystems.com> <4B2CBA8A.5030905@ti.com>
 <87k4wfrm89.fsf@deeprootsystems.com> <4B4520CF.3000306@ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870300519667@dbde02.ent.ti.com>
 <4B45A0F5.1020603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49184 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033Ab0AGJOE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 04:14:04 -0500
In-Reply-To: <4B45A0F5.1020603@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "K, Ambresh" <ambresh@ti.com>

Yes Vijay tried with your OPP patches on 3630 ZOOM3 and it seems to work.

Vishwa

> -----Original Message-----
> From: Dasgupta, Romit
> Sent: Thursday, January 07, 2010 2:23 PM
> To: Sripathy, Vishwanath
> Cc: Menon, Nishanth; Kevin Hilman; linux-omap; Cousson, Benoit; Chikkature
> Rajashekar, Madhusudhan; Paul Walmsley; Premi, Sanjeev; Shilimkar, Santosh;
> Aguirre, Sergio; Gopinath, Thara; K, Ambresh
> Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
> 
> Sripathy, Vishwanath wrote:
> > Nishant,
> > Have you tested your opp patches on 3630? Apparently opp changes in wip branch
> does not even boot on ZOOM3 board.
> >
> > Vishwa
> Vishwa,
>           did you try on top of my OPP patches?
> 
> Thanks,
> -Romit
