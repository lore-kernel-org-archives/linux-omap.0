From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix IGEPv2 second MMC channel power supply
Date: Sun, 14 Nov 2010 09:14:41 -0600
Message-ID: <14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59630 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab0KNPOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Nov 2010 10:14:45 -0500
In-Reply-To: <1289734452-31625-1-git-send-email-maz@misterjones.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <maz@misterjones.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>

Hi,

On Sun, 14 Nov 2010 11:34:12 +0000, Marc Zyngier <maz@misterjones.org>
wrote:
> @@ -272,8 +273,8 @@ static struct regulator_init_data igep2_vmmc1 = {
>  					| REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> -	.num_consumer_supplies  = 1,
> -	.consumer_supplies      = &igep2_vmmc1_supply,
> +	.num_consumer_supplies  = 2,

use ARRAY_SIZE(igep2_vmmc1_supplies),

-- 
balbi
