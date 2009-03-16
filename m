From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.29-rc8-omap] twl4030 power scripts, initsection
	fixups
Date: Mon, 16 Mar 2009 23:46:43 +0200
Message-ID: <20090316214643.GG551@gandalf>
References: <200903131825.52114.david-b@pacbell.net> <200903141200.53768.david-b@pacbell.net> <20090316002419.GA551@gandalf> <200903161411.41810.david-b@pacbell.net> <20090316213218.GE551@gandalf> <20090316214137.GF551@gandalf>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57173 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbZCPVqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 17:46:51 -0400
Content-Disposition: inline
In-Reply-To: <20090316214137.GF551@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, OMAP <linux-omap@vger.kernel.org>

On Mon, Mar 16, 2009 at 11:41:37PM +0200, Felipe Balbi wrote:
> On Mon, Mar 16, 2009 at 11:32:19PM +0200, Felipe Balbi wrote:
> > On Mon, Mar 16, 2009 at 02:11:41PM -0700, David Brownell wrote:
> > > On Sunday 15 March 2009, Felipe Balbi wrote:
> > > > how about applying this one instead ?
> > > 
> > > Looks OK to me, though it implies re-ordering the patches
> > > I sent on Friday since change prevents the updated
> > > 
> > >  From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
> > >  Subject: Group and resource assignments for TWL4030
> 
> Actually, this patch doesn't apply on current HEAD. Any dependency ?

nevermind. Found it.

Depends on "expose VPLL2" patch. Sending this one rebased in a bit

-- 
balbi
