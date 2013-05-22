From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] ARM: dts: OMAP2+: use #include for all device trees
Date: Wed, 22 May 2013 08:40:06 -0700
Message-ID: <20130522154006.GB10378@atomide.com>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37744 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756444Ab3EVPkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 May 2013 11:40:10 -0400
Content-Disposition: inline
In-Reply-To: <1369232864-14460-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130522 07:33]:
> Replace /include/ by #include for OMAP2+ DT, in order to use the
> C pre-processor, making use of #define features possible.

This is good, but let's use it with case. Probably the best use
for this right now is to add defines for the mux modes from
mach-omap2/mux.h as that makes the raw values readable without
comments.

Regards,

Tony
