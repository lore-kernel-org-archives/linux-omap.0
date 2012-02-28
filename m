From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove apply_uV constraints for fixed
 regulator
Date: Tue, 28 Feb 2012 15:57:06 -0800
Message-ID: <20120228235706.GJ18901@atomide.com>
References: <1330421554-29369-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55110 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab2B1X5J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 18:57:09 -0500
Content-Disposition: inline
In-Reply-To: <1330421554-29369-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120228 01:01]:
> VUSB is a fixed regulator, so get rid of the apply_uV constraint
> for it, which fixes the following error seen at boot on omap4
> SDP and PANDA boards.
> 
> machine_constraints_voltage: VUSB: failed to apply 3300000uV constraint
> twl_reg twl_reg.46: can't register VUSB, -22
> twl_reg: probe of twl_reg.46 failed with error -22

Thanks applying into fixes.

Tony
