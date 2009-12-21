From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 1/2] io: remove redundant params in omap2_init_common_hw
Date: Mon, 21 Dec 2009 12:37:47 +0530
Message-ID: <4B2F1EC3.3060001@ti.com>
References: <1261228253-30283-1-git-send-email-nm@ti.com> <1261228253-30283-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60846 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbZLUHHz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Dec 2009 02:07:55 -0500
In-Reply-To: <1261228253-30283-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: kevin h <khilman@deeprootsystems.com>, linux omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>

> -	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL);


A call to a function with NULL parameters suggests that the function is doing
more than it should. I think omap2_init_common_hw and omap2_sdrc_init,
_omap2_init_reprogram_sdrc, gpmc init can be separated from
omap2_init_common_hw. If you are refactoring the code may be this should be
taken care as well.
