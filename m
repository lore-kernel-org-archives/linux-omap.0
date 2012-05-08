From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/4] ARM: OMAP2+: CLEANUP: Add new config option
 for different DPLL features
Date: Tue, 8 May 2012 09:12:12 -0700
Message-ID: <20120508161212.GX5088@atomide.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
 <1336489364-19200-5-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51936 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207Ab2EHQMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 12:12:15 -0400
Content-Disposition: inline
In-Reply-To: <1336489364-19200-5-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:10]:
> This patch cleans up dpll_data structure, making structure
> fields definition based on feature availability for given SoC,
> managed using Kconfig rules.
> 
> SOC_HAS_DPLL_IDLE: idle state
> SOC_HAS_DPLL_RECAL: recalibration capability
> SOC_HAS_DPLL_DCO_SEL: dco selection
> SOC_HAS_DPLL_SDDIV: sigma-delta div factor
> SOC_HAS_DPLL_FREQSEL: frequency selection

These too should be SOC_HAS_OMAPXYZ_DPLL_IDLE etc.

Regards,

Tony
