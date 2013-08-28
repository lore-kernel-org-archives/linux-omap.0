From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
Date: Wed, 28 Aug 2013 17:39:13 +0530
Message-ID: <521DE869.6020503@ti.com>
References: <cover.1375443858.git.afzal@ti.com> <20130813080159.GT7656@atomide.com> <5211BD07.9090309@ti.com> <52133482.7080405@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55030 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3H1MJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Aug 2013 08:09:41 -0400
In-Reply-To: <52133482.7080405@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, "Kristo, Tero" <t-kristo@ti.com>

Hi Benoit,

On Tuesday 20 August 2013 02:48 PM, Benoit Cousson wrote:

> Otherwise, I guess that most of these patches should be non-intrusive
> for other OMAPs beside that one (ARM: OMAP2+: CM: reintroduce SW_SLEEP
> for OMAP4). And for the moment, that's maybe the most important point.
> 
> Have you checked that it will not generate any regression for OMAP4 in
> term of PM features: suspend, cpuidle at least?

As noted by Rajendra, there could problem where clockdomain doesn't have
SW_SLEEP and only have HW_AUTO. I have to rework the relevant patch to
handle it properly.

Regards
Afzal

