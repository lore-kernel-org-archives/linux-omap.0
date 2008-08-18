From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
	linux-omap
Date: Mon, 18 Aug 2008 16:12:18 +0300
Message-ID: <20080818131218.GI17827@atomide.com>
References: <20080815.133409.81509340.Hiroshi.DOYU@nokia.com> <20080815112112.GB16840@atomide.com> <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com> <20080815.234833.245337318.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60222 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYHRNMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 09:12:42 -0400
Content-Disposition: inline
In-Reply-To: <20080815.234833.245337318.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org, soni.trilok@gmail.com, h-kanigeri2@ti.com, x00omar@ti.com, grgupta@ti.com, felipe.contreras@nokia.com, felipe.contreras@gmail.com, vpasam@ti.com

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080815 23:49]:
> Hi Richard,
> 
> It sounds to me that you meant that "omapzoom" should be the center of
> the bridge development because of TI's internal expertise of this
> area. I don't have any explicit objections at all and, at least, I
> will pay some respects on omapzoom since originally TI has published
> this bridge as GPLv2.
> 
> But, in any case, we need the place to work together efficiently
> now in the community. I think that "linux-omap" should have this
> bridge code in itself. In that case, one could easily participate in
> this bridge development without bridge porting from
> "omapzoom". Otherwise, everyone who mainly uses "linux-omap" has to
> port the bridge from "omapzoom" to "linux-omap" whenever one tries to
> use the bridge. And also "linux-omap" is the most active development
> place for omap kernel in public. It would be really nice if TI experts
> participate.
> 
> As for the roadmap issue, I think that it's a matter of trade-off. The
> more open it is, the more benefit it gets from the community;).

At least we need to have the DSP MMU and mailbox stuff in linux-omap
tree in a clean way that's also merged to the mainline Linux.

After that, it should be possible to build the rest of the DSP code
as a module. And not have to deal with the MMU merging pains in multiple
places everytime something changes upstream.

Regards,

Tony


> 
>      Hiroshi DOYU
> 
> From: "ext Woodruff, Richard" <r-woodruff2@ti.com>
> Subject: RE: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
> Date: Fri, 15 Aug 2008 11:01:31 -0500
> 
> > Hi,
> > 
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > > * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080815 13:34]:
> > > > Thank you guys for your comments,
> > > >
> > > > It seems that some of the patches couldn't be sent to ML because of
> > > > the size limitation of vger.kernel.org ML. Now Tony is finding the
> > > > place to put the rest up on somewhere for review. I don't know if
> > > > reviwing these base code makes so much sense at this momenent,
> > > > though..which doesn't mean "no probelm";p
> > >
> > > I've copied your patches to:
> > >
> > > http://www.muru.com/linux/tidspbridge/
> > >
> > > > I hope that everyone could work together on this branch without any
> > > > problems eventually.
> > >
> > > We need to also figure out who's going to maintain the dspbridge
> > > branch. Ideally somebody with experience with dsp and linux..
> > 
> > Really all the design, maintenance and test experience of that code
> > is inside of TI.  This has lived for years and derivates have
> > shipped in products.  Who ever watches over it needs to be able to
> > provide a creditable multi-year commitment.
> > 
> > As part of contributing this code there has been a lot of reworking
> > of the code. Last I had heard checkpatch and sparse warnings had
> > been killed. There was also a lot of work in making sure there would
> > be no legal impact to the kernel to clear its ability to be
> > contributed.
> > 
> > If people really need it to work and not re-wait for a year, some
> > sane strategy needs to be employed. Most people in the mainline
> > kernel just won't care about a niche driver like this. As such the
> > only real gate for its inclusion is mainly _here_.
> > 
> > As there are many users/customers putting a solid and functional 1.0
> > in place would benefit everyone who needs it and would allow
> > cooperative development to ensure it would indeed work starting
> > _today_ and continuing into the future.  TI users _today_ use and
> > need this bridge.
> > 
> > Major interface and functional partitioning changes will happen as
> > such a piece of code evolves. This kind of thing seems more like 2.0
> > goals.  The point is that is something to be planned in a ToDo list.
> > Are their missing functions in what it provides today?
> > 
> > For this kind of piece to be successful it needs support from many
> > sides.
> > 
> > TI is willing to support this and has the necessary critical
> > technical context, incentive and attention span. Agreement is needed
> > on roadmap aspects of the code. If that doesn't happen what will
> > result is a lot of local patches on everyone's development tree.
> > 
> > We have been talking about hosting it on zoom as all the originators
> > and current experts of that code have direct access.
