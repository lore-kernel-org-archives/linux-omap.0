From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/5] OMAP4: mux: Add the OMAP4430 ES1 support
Date: Mon, 18 Oct 2010 16:00:13 -0700
Message-ID: <20101018230013.GI13341@atomide.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014FAB2762@dlee02.ent.ti.com>
 <4CBCB35E.9080502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51705 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0JRXAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 19:00:16 -0400
Content-Disposition: inline
In-Reply-To: <4CBCB35E.9080502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Cousson, Benoit <b-cousson@ti.com> [101018 13:42]:
> Hi Nishanth,
> 
> On 10/18/2010 8:09 PM, Menon, Nishanth wrote:
> >>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>owner@vger.kernel.org] On Behalf Of Benoit Cousson
> >>
> >Ping? Is there a possibility for a v2 non-rfc ES2 support?
> 
> And what about a RFC v2? With ES2 support of course :-)
> 
> The changes I have done are breaking RX51 support due to the usage
> of low-level API from the mux code.
> 
> For the moment I just disabled that code from the RX51, so there is
> no way I send that except in a RFC form :-(

I have some ideas on doing the board specific runtime remuxing.
That should also solve the rx51 emmc remuxing.

Let's plan on merging your patches first after the merge window,
then I'll do my patches on top of yours to avoid rebasing.

Regards,

Tony
