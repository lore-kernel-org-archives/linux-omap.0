From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
Date: Tue, 24 Feb 2015 09:57:25 +0000
Message-ID: <54EC4B05.6020000@arm.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com> <20150223230205.GJ32521@atomide.com> <20150224001145.GK32521@atomide.com> <CAJydem=O0S0dKL6pOvm79bNYinDcFVhQE0qUW43Qhvfo7voqtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33574 "EHLO
	usa-sjc-mx-foss1.foss.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752321AbbBXJ5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 04:57:30 -0500
In-Reply-To: <CAJydem=O0S0dKL6pOvm79bNYinDcFVhQE0qUW43Qhvfo7voqtA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Subramaniam Chanderashekarapuram <c.a.subramaniam@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24/02/15 03:45, Subramaniam Chanderashekarapuram wrote:
> 
> Tested this on  DRA7 for smp_affinity. Needs these minor fixes attached.
> 
> Note: I do not have a OMAP4/5 with me now. Hope to test that tomorrow.
> 
> Log for DRA7 are here:
> http://pastebin.ubuntu.com/10382176/

Looks good to me. I've folded that into the existing series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
