From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Tue, 01 Mar 2011 17:29:41 +0100
Message-ID: <1298996981.6461.5.camel@maggie>
References: <1298925943.16391.19.camel@marge>
	 <AANLkTikmwLoUPJrFZ2o7qsO8MbxBLe2hMbetwxeToW-Z@mail.gmail.com>
	 (sfid-20110301_172419_032506_64300D9A)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:57774 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756298Ab1CAQ3r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 11:29:47 -0500
In-Reply-To: <AANLkTikmwLoUPJrFZ2o7qsO8MbxBLe2hMbetwxeToW-Z@mail.gmail.com> (sfid-20110301_172419_032506_64300D9A)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

On Tue, 2011-03-01 at 11:23 -0500, Varadarajan, Charulatha wrote: 
> > My temporary workaround to this issue is to disable
> > soft reset for the first GPIO module:
> >
> >        static struct omap_hwmod omap2420_gpio1_hwmod = {
> >                .name           = "gpio1",
> >                .flags          = HWMOD_INIT_NO_RESET, /* Workaround: Don't reset the n810 MIPID */
> 
> NACK.
> 
> As the problem is specific to the board settings, this shall be handled
> in the board file itself.

Yeah, sure. But how can I handle this in the board file? Is
there a hwmod API for this?

> > I'm wondering if a better fix suitable for the mainline
> > kernel inclusion could be found.
> > Any ideas?
> 
> Re-initialize the  "nreset" line of the Blizzard in the
> corresponding board file.

That is not sufficient. The blizzard chip has to be reinitialized
completely.
Code for that doesn't exist in the current driver. It currently depends
on the bootloader doing the lowlevel init. As long as I don't have
documentation for that chip, I'm stuck with that.

-- 
Greetings Michael.

