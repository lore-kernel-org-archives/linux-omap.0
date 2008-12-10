From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: status of USB on omap35xx ?
Date: Wed, 10 Dec 2008 19:40:30 +0200
Message-ID: <20081210174030.GD9799@frodo>
References: <1228870250.32014.148.camel@localhost.localdomain> <20081210144604.GD13287@gandalf.research.nokia.com> <1228926833.32014.162.camel@localhost.localdomain>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54325 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbYLJRkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 12:40:37 -0500
Content-Disposition: inline
In-Reply-To: <1228926833.32014.162.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jeff Steele <jsteele@coloradocollege.edu>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, Dec 10, 2008 at 09:33:53AM -0700, Jeff Steele wrote:
> On Wed, 2008-12-10 at 16:46 +0200, Felipe Balbi wrote:
> > > 3) Is the Host port working pretty reliably, or are there any issues
> > > still to be resolved ?
> > 
> > ehci driver still needs some work. You can help
> > 
> 
> 
> 
> What are the issues ? 
> 
> ???
> ???I really only need to read bulk packets from one HS device that is
> present at boot.

It think it still has a problem during probe. If you read the driver
you'll see there are some infinite while loops without timeout actions.
And one of them is looping forever due to clock issues.

Donno if that's fixed by now. Worth trying.

-- 
balbi
