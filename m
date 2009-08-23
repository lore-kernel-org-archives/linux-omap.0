From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch format for submission?
Date: Mon, 24 Aug 2009 00:36:27 +0300
Message-ID: <20090823213627.GA6440@nokia.com>
References: <1250695463.10817.4.camel@blitz>
 <alpine.DEB.2.00.0908190921130.5294@utopia.booyaka.com>
 <4A8C28E6.7060209@am.sony.com>
 <87skflmhwh.fsf@deeprootsystems.com>
 <1250865273.8268.7.camel@blitz>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40154 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbZHWVll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 17:41:41 -0400
Content-Disposition: inline
In-Reply-To: <1250865273.8268.7.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Peter Barada <peterb@logicpd.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tim Bird <tim.bird@am.sony.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Aug 21, 2009 at 04:34:33PM +0200, ext Peter Barada wrote:
> On Fri, 2009-08-21 at 15:10 +0200, Kevin Hilman wrote:
> > Tim Bird <tim.bird@am.sony.com> writes:
> > 
> > > Paul Walmsley wrote:
> > >> Hi Peter,
> > >> 
> > >> On Wed, 19 Aug 2009, Peter Barada wrote:
> > >> 
> > >>> 1) Does anyone have a URL of the format patches should be in that are
> > >>> submitted to the linux-omap list?
> > >>>
> > >>> I've got some patches to add base support for the Logic OMAP 35x SOM and
> > >>> Torpedo boards and I'd like to submit them in the right format for
> > >>> inclusion and push into mainline.
> > >> 
> > >> Documentation/SubmittingPatches and Documentation/CodingStyle are pretty 
> > >> good intros to this.
> > >>
> > > Also, Andrew Morton wrote a paper called "The Perfect Patch"
> > > with a nice checklist of attributes.
> > >
> > > http://userweb.kernel.org/~akpm/stuff/tpp.txt
> > >
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

git svn clone <repository url> <local repo name>

will do it.

Something like:

git svn clone https://www.mydomain.com/svn/project/trunk project

then you can even commit and push to a svn tree. after getting newest
git tarball from [1], you can:

$ make prefix=/usr all doc
# make prefix=/usr install install-doc
$ git help svn

then you get git installed and help about svn support on git ;-)

[1] http://www.kernel.org/pub/scm/git/git-1.6.4.1.tar.bz2

-- 
balbi
