From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/4] TI816X: Update common omap platform files
Date: Wed, 9 Feb 2011 17:39:10 -0800
Message-ID: <20110210013910.GF20795@atomide.com>
References: <1297270555-32447-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33600 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab1BJBjk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 20:39:40 -0500
Content-Disposition: inline
In-Reply-To: <1297270555-32447-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com

Hi,

* Hemant Pedanekar <hemantp@ti.com> [110209 08:54]:
> 
>  1) Multi-OMAP build with CONFIG_SOC_OMAPTI816X: The kernel built only for
>  TI816X OMAP3 SoCs along with any other OMAP2/4 (e.g., OMAP4s). May not boot
>  on other OMAP3 SoCs.

This option does not sound right. For the multi-omap builds we need to have
the system working for all the processors, there should not be any reason
not to have things working.

Do you have some example in mind where other omaps break? If so, we should
just fix that issue.

Regards,

Tony 
