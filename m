From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 30/35] ARM: dts: omap4: add minimal l4 bus layout with
 control module support
Date: Mon, 30 Mar 2015 16:01:17 -0700
Message-ID: <20150330230116.GM10805@atomide.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
 <1426877086-17131-31-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:40898 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbbC3XFX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 19:05:23 -0400
Content-Disposition: inline
In-Reply-To: <1426877086-17131-31-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, sakari.ailus@iki.fi, linux-arm-kernel@lists.infradead.org

Hi,

* Tero Kristo <t-kristo@ti.com> [150320 11:46]:
> This patch creates the l4_cfg and l4_wkup interconnects for OMAP4, and
> moves some of the generic peripherals under it. System control module
> support is added to the device tree also, and the existing SCM related
> functionality is moved under it.

Doing a diff on the dmesg output before and after this series now
produces this extra warning on omap4:

+ti_dt_clk_init_provider: scm_conf missing 'clocks' child node

Regards,

Tony
