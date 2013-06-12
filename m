From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/4] ARM: dts: AM33XX: Add PWMSS device tree nodes
Date: Wed, 12 Jun 2013 18:10:32 +0200
Message-ID: <51B89D78.6010906@linutronix.de>
References: <1370526759-31163-1-git-send-email-bigeasy@linutronix.de> <1370526759-31163-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370526759-31163-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

On 06/06/2013 03:52 PM, Sebastian Andrzej Siewior wrote:
> From: Philip Avinash <avinashphilip@ti.com>
> 
> Add PWMSS device tree nodes in relation with ECAP & EHRPWM DT nodes to
> AM33XX SoC family. Also populates device tree nodes for ECAP & EHRPWM by
> adding necessary properties like pwm-cells, base reg & set disabled as
> status.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Can someone please grab #2 till #4? Paul took just #1 as far as I can
tell.

Sebastian
