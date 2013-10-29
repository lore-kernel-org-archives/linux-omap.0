From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 6/8] ARM: dts: OMAP4: Add hwspinlock node
Date: Tue, 29 Oct 2013 13:59:35 -0700
Message-ID: <20131029205935.GG15154@atomide.com>
References: <1381439735-52888-1-git-send-email-s-anna@ti.com>
 <1381439735-52888-7-git-send-email-s-anna@ti.com>
 <20131011234125.GG29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18488 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752803Ab3J2U7l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 16:59:41 -0400
Content-Disposition: inline
In-Reply-To: <20131011234125.GG29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131011 16:49]:
> * Suman Anna <s-anna@ti.com> [131010 14:24]:
> > Add the hwspinlock device tree node for OMAP4 family
> > of SoCs.
> 
> Suman, can you please post the .dts changes separately from
> the driver changes next time so driver maintainers don't
> accidentally pick them up. That leads to unnecessary merge
> conflicts with the .dts files.

Actually I'll pick patches 6 - 8 of this series into
omap-for-v3.13/dt branch as that fixes some boot time warnings
we're seeing without them.

Regards,

Tony
