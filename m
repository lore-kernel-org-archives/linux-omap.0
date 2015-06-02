From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Tue, 2 Jun 2015 16:54:10 +0530
Message-ID: <556D925A.9070708@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com> <1433159614-437-3-git-send-email-vigneshr@ti.com> <556D6781.2090405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58113 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbFBLZB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 07:25:01 -0400
In-Reply-To: <556D6781.2090405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org

Hi Tero,

On Tuesday 02 June 2015 01:51 PM, Tero Kristo wrote:
> On 06/01/2015 02:53 PM, Vignesh R wrote:
>> Add hwmod entries for the PWMSS on DRA7.
> 
> Can you provide some documentation references for this data?
> 
> I was looking at the TRM and at least the main_clk selection is somewhat
> unclear to me.

As per AM57x TRM SPRUHZ6, October 2014, Section 29.1.3 Table 29-4.
source signal as L4PER2_L3_GICLK but it is actually equal to
L4PER2_L3_GICLK/2. l4_root_clock_div is fixed-factored clock equal to
L4PER2_L3_GICLK/2 (l3_iclk_div/2 in Linux clock dt). The TRM does'nt
show factor of by 2. I will forward you an internal documentation that
talks about this.

I also measured the frequencies of PWM waveforms using oscilloscope and
it matches above observation.

I will update the patch description in v2.

Regards
Vignesh

