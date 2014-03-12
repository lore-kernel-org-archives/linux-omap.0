From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 1/2] arm: dts: dra7: Add qspi device.
Date: Wed, 12 Mar 2014 10:34:45 -0700
Message-ID: <20140312173444.GF30897@atomide.com>
References: <1394452263-12975-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22597 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755668AbaCLReu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 13:34:50 -0400
Content-Disposition: inline
In-Reply-To: <1394452263-12975-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Sourav Poddar <sourav.poddar@ti.com> [140310 04:54]:
> These add device tree entry for qspi controller driver on dra7-evm.

It seems that we need to wait for the crossbar dependencies
to get cleared in the mainline kernel before we can apply this
as otherwise the interrupts will be wrong in omap-for-v3.15/dt
branch.

Regards,

Tony
