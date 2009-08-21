From: Peter Barada <peterb@logicpd.com>
Subject: Re: Patch format for submission?
Date: Fri, 21 Aug 2009 10:34:33 -0400
Message-ID: <1250865273.8268.7.camel@blitz>
References: <1250695463.10817.4.camel@blitz>
	 <alpine.DEB.2.00.0908190921130.5294@utopia.booyaka.com>
	 <4A8C28E6.7060209@am.sony.com>  <87skflmhwh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:47556 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932161AbZHUOaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Aug 2009 10:30:06 -0400
In-Reply-To: <87skflmhwh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tim Bird <tim.bird@am.sony.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 2009-08-21 at 15:10 +0200, Kevin Hilman wrote:
> Tim Bird <tim.bird@am.sony.com> writes:
> 
> > Paul Walmsley wrote:
> >> Hi Peter,
> >> 
> >> On Wed, 19 Aug 2009, Peter Barada wrote:
> >> 
> >>> 1) Does anyone have a URL of the format patches should be in that are
> >>> submitted to the linux-omap list?
> >>>
> >>> I've got some patches to add base support for the Logic OMAP 35x SOM and
> >>> Torpedo boards and I'd like to submit them in the right format for
> >>> inclusion and push into mainline.
> >> 
> >> Documentation/SubmittingPatches and Documentation/CodingStyle are pretty 
> >> good intros to this.
> >>
> > Also, Andrew Morton wrote a paper called "The Perfect Patch"
> > with a nice checklist of attributes.
> >
> > http://userweb.kernel.org/~akpm/stuff/tpp.txt
> >
> 
> In addition to above suggestions, I highly recommend using git tools
> which automate many of these recommended steps.
> 
> Usin 'git format-patch' and then 'git send-email' will get you a long
> ways.

Kevin,

Most of my work is done with LTIB/svn.  Is there a good starter document
for git on how to have a local tree, local changes, and keep it up to
date with a remote tree?  I've waded through some of git's
documentation, but its bit daunting bending my brain around git after
many years of SVN/CVS.

1) If I use "git fetch" to create a local copy, how do I check in
changes to my tree (that stay local), then update my tree to changes
you've made?  I assume this is where rebasing comes in, but I'm unclear
on the process - I've littered my machine with multiple busted git trees
trying to track yours and Tony's trees/branches/tags.  Any quick
examples are highly appreciated.

2) Are there tools to take an SVN tree and "import" it into a git tree
(or do I have to do that by hand, patching my git tree foreach SVN
revision I have)?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
