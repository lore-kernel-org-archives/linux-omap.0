From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/86] OMAP2/3: clock sync with linux-omap
Date: Thu, 19 Mar 2009 02:57:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903190243560.3086@utopia.booyaka.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35162 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827AbZCSI5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 04:57:53 -0400
In-Reply-To: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com

Hello Russell,

On Thu, 12 Mar 2009, Kevin Hilman wrote:

> This is the series of patches contained in the 'omap-clks3' branch of
> Russell King's git repository[1].  Posted on behalf of Russell who
> had some mail issues in first attempt, and then ran of out time.
> 
> This series is proposed to be merged into the next merge window.
> 
> Comments to the list appreciated.

I've spent some time reviewing these patches.

Many of the changes you've implemented are an improvement over the 
previous code.  Some of the patches would ordinarily prompt further 
comments and revision, but the benefit of merging these patches upstream 
in this merge window exceeds the benefit of further revision.

So my preference would be to see this current set sent upstream for this 
merge window.


regards,

- Paul
