From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: [PATCH 0/2] OMAP3: PM: More pedantic parameter and error
	checking in smartreflex
Date: Wed, 13 May 2009 18:36:00 +0300
Message-ID: <1242228960.9103.119.camel@pcarmody-desktop>
References: <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
	 <87bppx82du.fsf@deeprootsystems.com>
Reply-To: ext-phil.2.carmody@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51585 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbZEMPfM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 11:35:12 -0400
In-Reply-To: <87bppx82du.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-05-13 at 17:10 +0200, ext Kevin Hilman wrote:
> Phil Carmody <ext-phil.2.carmody@nokia.com> writes:
> 
> > A couple of simple patches to improve error handling in smartreflex.
> > The first has a practical benefit of avoiding a string-based search
> > in situtations where the result wouldn't be needed. The second is
> > simple paranoia.
> 
> Thanks, pushing this series today.
> 
> Note that I pushed this on top of Rajendra's patch:
> "OMAP3: SR: Fix SR driver to check for omap-pm return values"
> and had to resolve a couple of conflicts.
> 
> Could you please sanity check it?

Sanity check successful. Many thanks, Kevin.

Phil

