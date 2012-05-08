From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 4/4] ARM: OMAP2+: CLEANUP: Add new config option for
 different DPLL features
Date: Tue, 8 May 2012 17:24:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1AF65@DBDE01.ent.ti.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
 <1336489364-19200-5-git-send-email-hvaibhav@ti.com>
 <20120508161212.GX5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53807 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2EHRYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 13:24:54 -0400
In-Reply-To: <20120508161212.GX5088@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 08, 2012 at 21:42:12, Tony Lindgren wrote:
> * Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:10]:
> > This patch cleans up dpll_data structure, making structure
> > fields definition based on feature availability for given SoC,
> > managed using Kconfig rules.
> > 
> > SOC_HAS_DPLL_IDLE: idle state
> > SOC_HAS_DPLL_RECAL: recalibration capability
> > SOC_HAS_DPLL_DCO_SEL: dco selection
> > SOC_HAS_DPLL_SDDIV: sigma-delta div factor
> > SOC_HAS_DPLL_FREQSEL: frequency selection
> 
> These too should be SOC_HAS_OMAPXYZ_DPLL_IDLE etc.
> 

Thanks Tony, I will change the option accordingly.
Do you have any further comments on this series? If, no, I will change the 
option name and submit immediately.

Thanks,
Vaibhav
