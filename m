From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH 2/2] OMAP:DSS: RFC Patch to add HDMI DSS driver support
Date: Wed, 29 Sep 2010 11:36:09 +0200
Message-ID: <20100929093609.GY28423@ibawizard.net>
References: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB4@dbde02.ent.ti.com> <1283865397.2363.110.camel@tubuntu.research.nokia.com> <FF55437E1F14DA4BAEB721A458B6701706C5776EFE@dbde02.ent.ti.com> <1283867099.2363.114.camel@tubuntu.research.nokia.com> <FF55437E1F14DA4BAEB721A458B6701706C5776FEB@dbde02.ent.ti.com>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:49145 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0I2JoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 05:44:17 -0400
Content-Disposition: inline
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706C5776FEB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

K, Mythri P <mythripk@ti.com> [2010-09-08 10:16:29]:

Hi,

[snip]

> Yes this is just a RFC patch to introduce the HDMI driver and panel as such,
> if you have no other comments on these 2 patch set I shall incorporate these
> comments and send out the complete patch series with all the relevant
> changes in display.h and some overlay.c and manager.c changes.

there's EDID parser[1] already in kernel, so you might better reuse it and/or
extend it for your needs.  The next thing is, that there's and there will be
the demand for EDID on OMAP3 also, so it might be wise to rethink it from the
beginning and split or write the code in a way, that it can be reused on OMAP3
also. I think, that at least the code for calculation of ideal video
resolution and timings could be made generic and could be used on OMAP3 also.
Or am I mistaken?

I'm adding Ricardo Salveti to the CC, he showed me his first draft of EDID
parsing[2] for OMAP3 yesterday. Yes, it's just the draft, but it's at least
reusing the code already available in kernel. I think, that the same could or
should apply for the OMAP4 code.

What I'm trying to say is, that I'm not uber kernel hacker, but I would like
to have EDID working on my Beagle also and I'll definitely help with this.

Thanks.

1. drivers/video/fbmon.c and drivers/video/edid.h
2. http://kernel.ubuntu.com/git?p=rsalveti/ubuntu-maverick.git;a=commitdiff;h=a0ea712b64988ccd7984069b99864a1b4ac43881

-- ynezz
