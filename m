From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
Date: Sun, 9 Jun 2013 07:13:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306090713090.20050@utopia.booyaka.com>
References: <1370526759-31163-1-git-send-email-bigeasy@linutronix.de> <1370526759-31163-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370526759-31163-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 6 Jun 2013, Sebastian Andrzej Siewior wrote:

> From: Philip Avinash <avinashphilip@ti.com>
> 
> EHRPWM module requires explicit clock gating of TBCLK from control
> module. Hence add TBCLK clock node in clock tree for EHRPWM modules.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> [bigeasy: remove CK_AM33XX]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks, queued.

- Paul
