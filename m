From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PREVIEW 2] New display subsystem for OMAP2/3
Date: Tue, 23 Sep 2008 16:38:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD7C959B@dbde02.ent.ti.com>
References: <20080923104037.GF5102@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbYIWLIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 07:08:14 -0400
In-Reply-To: <20080923104037.GF5102@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath
Senior Software Engg.
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> Lindgren
> Sent: Tuesday, September 23, 2008 4:11 PM
> To: Koen Kooi
> Cc: linux-omap@vger.kernel.org List
> Subject: Re: [PREVIEW 2] New display subsystem for OMAP2/3
> 
> * Koen Kooi <k.kooi@student.utwente.nl> [080923 13:27]:
> >
> > Op 23 sep 2008, om 11:24 heeft Tony Lindgren het volgende geschreven:
> >
> >> * Koen Kooi <k.kooi@student.utwente.nl> [080923 11:41]:
> >>>
> >>> Op 23 sep 2008, om 10:19 heeft Tomi Valkeinen het volgende
> >>> geschreven:
> >>>> On Mon, 2008-09-22 at 18:10 +0300, ext Tony Lindgren wrote:
> >>>>> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [080922 17:49]:
> >
> >>>>> I sent a preview of a new display subsystem for OMAP2/3 some time
> >>>>>> ago:
> >>>>>> http://marc.info/?l=linux-omap&m=122114505030542&w=2
> >>>>>>
> >>>>>> I now have updated it, the patches are at the same place:
> >>>>>> http://www.bat.org/~tomba/omap-dss/
> >>>>>
> >>>>> This discussion should go to linux-fbdev-devel list. Please keep
> >>>>> l-o
> >>>>> list Cc'd though. Also you should post the patches as a proper
> >>>>> inline
> >>>>> series, please see git-send-email man page.
> >>>>>
> >>>>
> >>>> Ok, I'll move it to linux-fbdev-devel.
> >>>>
> >>>> I didn't post the patches inline, as they are quite big (250k+). I
> >>>> thought there was a "rule" to put big patches to some public place,
> >>>> not
> >>>> to mail them.
> >>>>
> >>>> What is the proper procedure for this work? Discuss and review the
> >>>> patches on fbdevel, and mail to l-o when finalized? Or go directly
> >>>> to
> >>>> Linus' tree?
> >>>
> >>> Or a branch on l-o (like pm-0)  that will get rebased when things
> >>> change.
> >>
> >> I'd suggest discussing it on fbdevel list, and then have the necessary
> >> patches included into the mainline kernel via fbdevel. If you cc l-o
> >> list, people will have a chance to comment also.
> >
> > This patch also hooks into boardcode for omap3 boards, which AFAIK
> > aren't in mainline yet, which makes it hard to funnel a working patch
> > through the fbdev tree to mainline. But apart from that, going through
> > fbdev-devel first would cut down on tedious review rounds later on.
> > Does davinci share enough bits to make this DSS lib work for that as
> > well?
> 

I believe that this discussion is happening for separate FBDEV driver which will be
compliant to DSS library posted few days back (http://lists-archives.org/video4linux/24409-omap2-3-dss-library.html).


> The drivers should be independent of the platform_data in the
> board-*.c files as it may take a while longer to get the omap3
> board-*.c files into the mainline kernel.
> 
> Tony
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

