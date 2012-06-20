From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v2 02/11] ARM: OMAP: expose control.h to mach area
Date: Wed, 20 Jun 2012 03:17:17 -0700
Message-ID: <20120620101716.GY12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <4FDF11C0.4090908@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28428 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab2FTKRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 06:17:25 -0400
Content-Disposition: inline
In-Reply-To: <4FDF11C0.4090908@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120618 04:36]:
> This patch exposes the definitions under control.h to
> drivers outside the machine code.

As discussed earlier, this will likely lead into misuse of these
registers that will be a big mess to clean up.

Can't you make these private to the driver(s)?

Tony
