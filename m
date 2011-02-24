From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP3 Touchbook: fix board initialization
Date: Thu, 24 Feb 2011 14:31:37 -0800
Message-ID: <20110224223137.GV20560@atomide.com>
References: <6dac4c4aac867da9cf2971ce555f54ac@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24132 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab1BXWbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 17:31:41 -0500
Content-Disposition: inline
In-Reply-To: <6dac4c4aac867da9cf2971ce555f54ac@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Radek =?utf-8?B?KE1ya3ZhKSBQaWxhxZk=?= <mrkva@mrkva.eu>
Cc: linux-omap@vger.kernel.org

* Radek (Mrkva) Pila=C5=99 <mrkva@mrkva.eu> [110224 10:08]:
> init_early hook runs too early for omap3_mux_init(), so the board
> won't boot. Moved to init_machine, then it works just fine.

Thanks, applying this. Will do a similar fix for other boards too.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
