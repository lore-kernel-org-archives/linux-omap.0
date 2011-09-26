From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/11] OMAP2+: Add SoC specific map_io functions
Date: Mon, 26 Sep 2011 16:15:16 -0700
Message-ID: <20110926231516.GI6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-2-git-send-email-b-cousson@ti.com>
 <20110923230049.GC6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38471 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823Ab1IZXPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 19:15:22 -0400
Content-Disposition: inline
In-Reply-To: <20110923230049.GC6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Tony Lindgren <tony@atomide.com> [110923 15:27]:
> * Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> > Add SoC specific map_io function to be used by the generic DT
> > board file. This is an intermediate step before having some
> > generic DT aware map_io function.
> 
> Thanks, I'll apply this into cleanup branch and with the related
> conversion of board files.

Following replies contain the two related patches.

Tony
