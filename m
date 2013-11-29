From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
Date: Fri, 29 Nov 2013 09:12:56 -0800
Message-ID: <20131129171256.GN31534@atomide.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <52969313.6090207@ti.com>
 <alpine.DEB.2.02.1311281857100.23429@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50114 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757738Ab3K2RNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 12:13:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1311281857100.23429@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [131128 10:59]:
> On Wed, 27 Nov 2013, Nishanth Menon wrote:
> 
> > http://pastebin.mozilla.org/3681900 -> AM3517-evm (not sure yet how
> > long this has been broken).
> 
> Seems to work in v3.13-rc1:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.13-rc1/20131124230250/boot/3517evm/3517evm_log.txt

FYI, not really related to the clock patches, but we're also missing the .dtsi
file for 3517 currently for the device tree based booting. I'm planning to take
a look at that next week.

Regards,

Tony
