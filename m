From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 19/19] HSI: omap_ssi: drop pm_runtime_irq_safe
Date: Tue, 21 Jun 2016 04:41:49 -0700
Message-ID: <20160621114147.GS22406@atomide.com>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
 <1466267229-25012-20-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466267229-25012-20-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160618 09:31]:
> pm_runtime_irq_safe increases the parents runtime usage
> counter effectively keeping the OMAP SoC from idling.

Good to see this :) Yeah pm_runtime_irq_safe keeps the parent
permanently enabled so not using it is the way to go:

Acked-by: Tony Lindgren <tony@atomide.com>
