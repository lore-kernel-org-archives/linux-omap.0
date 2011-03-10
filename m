From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 0/9] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 10 Mar 2011 09:21:27 +0200
Message-ID: <1299741687.2017.5.camel@deskari>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	 <1299680106.2151.91.camel@deskari>
	 <AANLkTi==-RuvQBgQedJjrhdORf3NAjue_QnaihRw5mME@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab1CJHVb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 02:21:31 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2A7LUqq005984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:21:30 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2A7LUPQ025729
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:21:30 -0600 (CST)
In-Reply-To: <AANLkTi==-RuvQBgQedJjrhdORf3NAjue_QnaihRw5mME@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-03-09 at 23:27 -0600, K, Mythri P wrote:
> Hi Tomi,
> yes This is based off your tree.
> 
> Thanks and regards,
> Mythri.


It looks like there were some whitespace issues. I don't know what
caused them...

Also, please don't top-post on public mailing lists.

 Tomi

> 
> On Wed, Mar 9, 2011 at 7:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
> >> Adding HDMI support on OMAP4.
> >>
> >> HDMI is a driver that is similar to the VENC or the DSI driver to support
> >> HDMI/DVI sink device.
> >>
> >> The current design adheres to the DSS2 architecture.
> >>
> >> It is split into the HDMI DSS driver and HDMI panel driver.
> >
> > This doesn't apply to my tree. Are you sure it's based on DSS master
> > branch?
> >
> > Applying: OMAP4 : DSS2 : Add display type HDMI to DSS2
> > Applying: OMAP4 : DSS2 : HDMI: Select between HDMI VENC clock source.
> > Applying: OMAP4 : DSS2 : HDMI: HDMI dispc gamma table disable.
> > Applying: OMAP4 : DSS2 : HDMI: HDMI driver header file addition
> > Applying: OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS
> > fatal: sha1 information is lacking or useless (drivers/video/omap2/dss/dss.h).
> > Repository lacks necessary blobs to fall back on 3-way merge.
> > Cannot fall back to three-way merge.
> > Patch failed at 0005 OMAP4 : DSS2 : HDMI: HDMI driver addition in the DSS
> > When you have resolved this problem run "git am -3 --resolved".
> > If you would prefer to skip this patch, instead run "git am -3 --skip".
> > To restore the original branch and stop patching run "git am -3 --abort".
> >
> >  Tomi
> >
> >
> >


