From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: AM33XX: fix ethernet and mdio default state
Date: Wed, 14 May 2014 14:45:35 -0700
Message-ID: <20140514214534.GK27426@atomide.com>
References: <1399539456-555-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51258 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaENVpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 17:45:40 -0400
Content-Disposition: inline
In-Reply-To: <1399539456-555-1-git-send-email-jhovold@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Johan Hovold <jhovold@gmail.com> [140508 01:59]:
> Make sure ethernet and mdio nodes are disabled by default and enable
> them explicitly only on boards that actually use them.

Thanks applying into omap-for-v3.16/dt.

Tony
