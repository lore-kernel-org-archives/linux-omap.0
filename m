From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/8] OMAP: hwmod: warn on missing clockdomain
Date: Thu, 3 Dec 2009 05:11:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030510520.13408@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.0911180404050.25515@utopia.booyaka.com>
 <878we3euyh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50041 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbZLCMLZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 07:11:25 -0500
In-Reply-To: <878we3euyh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Wed, 18 Nov 2009, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > Hi Kevin
> >
> > On Tue, 17 Nov 2009, Kevin Hilman wrote:
> >
> >> WARN if a clock/hwmod is missing a clockdomain association since
> >> resulting hwmod will not be able to correctly enable/disable clocks.
> >
> > Wouldn't this check be best placed in the clock code?  
> 
> Possibly.  The idea here was to flag an issue that will prevent the
> hwmod code from crashing.

You've convinced me :-)  We should wait to move it into the clock code 
until all clocks are associated with clockdomains.  Until then, let's take 
your patch.


- Paul
