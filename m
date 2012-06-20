From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and
 clk_disable_unprepare
Date: Wed, 20 Jun 2012 04:41:49 -0700
Message-ID: <20120620114149.GG12766@atomide.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-5-git-send-email-rnayak@ti.com>
 <20120614191147.GP19410@gmail.com>
 <4FDAC07A.7020702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19208 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2FTLlw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 07:41:52 -0400
Content-Disposition: inline
In-Reply-To: <4FDAC07A.7020702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Mike Turquette <mturquette@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120614 22:01]:
> On Friday 15 June 2012 12:41 AM, Mike Turquette wrote:
> >On 20120614-18:16, Rajendra Nayak wrote:
> >>As we move to Common clk framework use clk_prepare_enable()
> >>instead of clk_enable() and similarly clk_disable_unprepare()
> >>instead of clk_disable()
> >>
> >>Based on initial changes from Mike turquette.

Sounds like these kind of patches should be a separate series
to prepare for the common clk fwk conversion? It seems these
could already get merged separately?

Tony
