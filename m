From: Jean Pihet <jpihet@mvista.com>
Subject: Re: Patch format for submission?
Date: Fri, 21 Aug 2009 17:20:16 +0200
Message-ID: <200908211720.17115.jpihet@mvista.com>
References: <1250695463.10817.4.camel@blitz> <87skflmhwh.fsf@deeprootsystems.com> <1250865273.8268.7.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:1130 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZHUPVG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 11:21:06 -0400
In-Reply-To: <1250865273.8268.7.camel@blitz>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tim Bird <tim.bird@am.sony.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

Hi!

On Friday 21 August 2009 16:34:33 Peter Barada wrote:
> On Fri, 2009-08-21 at 15:10 +0200, Kevin Hilman wrote:
> > Tim Bird <tim.bird@am.sony.com> writes:
> > > Paul Walmsley wrote:
> > >> Hi Peter,
> > >>
> > >> On Wed, 19 Aug 2009, Peter Barada wrote:
> > >>> 1) Does anyone have a URL of the format patches should be in that are
> > >>> submitted to the linux-omap list?
> > >>>
> > >>> I've got some patches to add base support for the Logic OMAP 35x SOM
> > >>> and Torpedo boards and I'd like to submit them in the right format
> > >>> for inclusion and push into mainline.
> > >>
> > >> Documentation/SubmittingPatches and Documentation/CodingStyle are
> > >> pretty good intros to this.
> > >
> > > Also, Andrew Morton wrote a paper called "The Perfect Patch"
> > > with a nice checklist of attributes.
> > >
> > > http://userweb.kernel.org/~akpm/stuff/tpp.txt
> >
> > In addition to above suggestions, I highly recommend using git tools
> > which automate many of these recommended steps.
> >
> > Usin 'git format-patch' and then 'git send-email' will get you a long
> > ways.
>
> Kevin,
>
> Most of my work is done with LTIB/svn.  Is there a good starter document
> for git on how to have a local tree, local changes, and keep it up to
> date with a remote tree?  I've waded through some of git's
> documentation, but its bit daunting bending my brain around git after
> many years of SVN/CVS.
You can start with the Git tutorial [1] and Everyday Git [2]. The entry point 
for git documentation is at [3].

[1] http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
[2] http://www.kernel.org/pub/software/scm/git/docs/everyday.html
[3] http://www.kernel.org/pub/software/scm/git/docs/git.html


> 1) If I use "git fetch" to create a local copy, how do I check in
> changes to my tree (that stay local), then update my tree to changes
> you've made?  I assume this is where rebasing comes in, but I'm unclear
> on the process - I've littered my machine with multiple busted git trees
> trying to track yours and Tony's trees/branches/tags.  Any quick
> examples are highly appreciated.
You use 'git fetch', 'git pull' and 'git rebase' commands for that, cf. [1] 
and [2].

> 2) Are there tools to take an SVN tree and "import" it into a git tree
> (or do I have to do that by hand, patching my git tree foreach SVN
> revision I have)?

Regards,
Jean

