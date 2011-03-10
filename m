From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 5/9] OMAP4 : DSS2 : HDMI: HDMI driver addition in
 the DSS
Date: Thu, 10 Mar 2011 09:57:49 +0200
Message-ID: <1299743869.2017.19.camel@deskari>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	 <1299671118-20839-2-git-send-email-mythripk@ti.com>
	 <1299671118-20839-3-git-send-email-mythripk@ti.com>
	 <1299671118-20839-4-git-send-email-mythripk@ti.com>
	 <1299671118-20839-5-git-send-email-mythripk@ti.com>
	 <1299671118-20839-6-git-send-email-mythripk@ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB593024C1922B3@dbde02.ent.ti.com>
	 <AANLkTin69+GHWfG6QHo65G_cpa9Odg3SDf4tgxgdXMyE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab1CJH5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 02:57:52 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2A7vpfF011145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:57:51 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p2A7vp9V008420
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:57:51 -0600 (CST)
In-Reply-To: <AANLkTin69+GHWfG6QHo65G_cpa9Odg3SDf4tgxgdXMyE@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-03-09 at 23:22 -0600, K, Mythri P wrote:
> Hi Sanjeev,
> 
> On Wed, Mar 9, 2011 at 9:20 PM, Premi, Sanjeev <premi@ti.com> wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of K, Mythri P
> >> Sent: Wednesday, March 09, 2011 5:15 PM
> >> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
> >> Cc: K, Mythri P
> >> Subject: [PATCH v4 5/9] OMAP4 : DSS2 : HDMI: HDMI driver addition in the
> >> DSS

<snip>

> >> +/*
> >> + * Logic for the below structure
> >> + * user enters the CEA or VESA timings by specifying
> >> + * the hdmicode which corresponds to CEA/VESA timings
> >> + * please refer to section 6.3 in HDMI 1.3 specification for timing code.
> >> + * There is a correspondence between CEA/VESA timing and code.
> >> + * In the below structure, cea_vesa_timings corresponds to all
> >> + * The OMAP4 supported timing  CEA and VESA timing values.
> >> + * code_cea corresponds to the CEA code entered by the user,
> >> + * The use of it is to get the timing from the cea_vesa_timing array.
> >> + * Similarly for code_vesa.
> >> + * code_index is backmapping, Once EDID is read from the TV
> >> + * EDID is parsed to find the timing values to map it back to the
> >> + * corresponding CEA or VESA index this structure is used.
> >> + */
> >
> > [sp] Is the comment intentionally formatted as it is?
> >     There seems to be an opportunity to improve the text and
> >     readability here.
> >
> I shall try to indent.

You can just select the whole comment and press "gw", that will arrange
the comment nicely. Presuming you use vim. And everybody does, don't
they? =)

 Tomi


