From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk info
 from DT
Date: Wed, 14 Aug 2013 19:43:10 +0530
Message-ID: <520B9076.2090702@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com> <1374560679-14666-3-git-send-email-rnayak@ti.com> <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com> <520B8409.5000708@ti.com> <520B88A0.6080806@ti.com> <20130814134904.GC13141@e106331-lin.cambridge.arm.com> <520B8D01.1040205@ti.com> <20130814140807.GE13141@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab3HNONt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 10:13:49 -0400
In-Reply-To: <20130814140807.GE13141@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "galak@codeaurora.org" <galak@codeaurora.org>, "mturquette@linaro.org" <mturquette@linaro.org>

[]..
> 
> From the sounds of your other reply, the issue is that you're poking
> clocks for arbitrary devices, without knowing the semantics of those
> clocks, because you're doing it form outside the driver.

Thats right.
