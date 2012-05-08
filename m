From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/4] ARM: OMAP2+: CLEANUP: Add new config option
 for different DPLL features
Date: Tue, 8 May 2012 10:26:57 -0700
Message-ID: <20120508172657.GY5088@atomide.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
 <1336489364-19200-5-git-send-email-hvaibhav@ti.com>
 <20120508161212.GX5088@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1AF65@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61678 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab2EHR1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 13:27:00 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA1AF65@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120508 10:28]:
> On Tue, May 08, 2012 at 21:42:12, Tony Lindgren wrote:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:10]:
> > > This patch cleans up dpll_data structure, making structure
> > > fields definition based on feature availability for given SoC,
> > > managed using Kconfig rules.
> > > 
> > > SOC_HAS_DPLL_IDLE: idle state
> > > SOC_HAS_DPLL_RECAL: recalibration capability
> > > SOC_HAS_DPLL_DCO_SEL: dco selection
> > > SOC_HAS_DPLL_SDDIV: sigma-delta div factor
> > > SOC_HAS_DPLL_FREQSEL: frequency selection
> > 
> > These too should be SOC_HAS_OMAPXYZ_DPLL_IDLE etc.
> > 
> 
> Thanks Tony, I will change the option accordingly.
> Do you have any further comments on this series? If, no, I will change the 
> option name and submit immediately.

Thanks, looks OK to me otherwise.

Tony
