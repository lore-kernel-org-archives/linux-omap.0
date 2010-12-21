From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] omap: rx51: Switch rx51_tpa6130a2_data __initdata to
 __initdata_or_module
Date: Mon, 20 Dec 2010 17:14:02 -0800
Message-ID: <20101221011402.GF5941@atomide.com>
References: <20101218002439.GA5941@atomide.com>
 <1292696230-31901-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59229 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864Ab0LUBOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 20:14:07 -0500
Content-Disposition: inline
In-Reply-To: <1292696230-31901-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [101218 10:17]:
> If the TPA6130 is compiled as module the id and power_gpio values are
> arbitrary at module probing time since the rx51_tpa6130a2_data was marked as
> __initdata. Fix this by using __initdata_or_module. Then __initdata is
> defined only if the kernel is built without CONFIG_MODULES and omitted
> otherwise.

Thanks applying.

Tony
