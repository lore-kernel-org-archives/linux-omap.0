From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 1/17] OMAP2/3/4:dmtimer:add device names to flck nodes
Date: Sat, 9 Oct 2010 20:30:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E840681@dbde02.ent.ti.com>
References: <1285059060-26316-1-git-send-email-tarun.kanti@ti.com>
 <4CA4F005.6000208@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CD032E6@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA901D8967A56@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab0JIPAp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 11:00:45 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA901D8967A56@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Benoit,

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Friday, October 01, 2010 12:54 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, Partha; DebBarma,
> Tarun Kanti; Paul Walmsley; Tony Lindgren; Kevin Hilman
> Subject: RE: [PATCHv3 1/17] OMAP2/3/4:dmtimer:add device names to flck
> nodes
> 
> Hi Charu,
> 
> >From: Varadarajan, Charulatha
> >Sent: Friday, October 01, 2010 7:27 AM
> >
> >Benoit,
> >
> >> >
> >> > This patch adds device name info to OMAP2 dmtimer fclk nodes so
> >>
> >> You should avoid using "that patch" in a changelog, since we already
> >> know it is a patch.
> >>
> >> You can read 4.c in "The perfect patch" from Andrew Morton:
> >> http://userweb.kernel.org/~akpm/stuff/tpp.txt
> >>
> >
> >Referring to 6.b section in the above link, is it a bad idea to have
> >a cover-letter? Should we better include the content of introductory
> >email in patch 1 of any patch series?
> 
> I saw it as well, and was a little bit surprised at first.
> But if you look carefully the rational, it makes sense if you do not take
> care about the content of the cover-letter.
> 
>    > Please don't do this.  There is no facility in the git tree to carry
>    > changelog-only changesets such as this (or at least, we don't do
> that) so
>    > the information in the introductory email will be lost.
>    >
>    > So I end up copying and pasting your nice introduction into the
>    > changelog for the first patch, so it gets into git.  I'll follow it
> with
>    > the text
> 
> Here the concern is that some important information can be in the cover-
> letter but not in the patch changelog, so they will be lost.
> That issue does not appear if you use the cover-letter only to summarize
> the patches changelog and to provide the history or the various patch
> series revision.
> At the end the history and the patch series revision should no go into the
> changelog anyway, so it is perfectly fine to lose them.
> 
> Bottom-line, keep doing cover-letter to summarize the series, but do not
> put information that should belong to the patch changelog only.
> 
Ok, I will take care.
-tarun
