From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: am33xx-hwmod: Fix wrongly terminated am33xx_usbss_mpu_irqs
 array
Date: Mon, 7 Jan 2013 20:09:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301072009170.31833@utopia.booyaka.com>
References: <1357252342-6166-1-git-send-email-panto@antoniou-consulting.com> <20130107200338.GD14149@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130107200338.GD14149@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Jan 2013, Tony Lindgren wrote:

> * Pantelis Antoniou <panto@antoniou-consulting.com> [130103 14:35]:
> > The IRQ array must be terminated by -1 and not by -1+OMAP_INTC_START
> > This led to having a resource list of 100s of IRQs.
> 
> This is a bug for sure introduced with commit a2cfc509 (ARM: OMAP3+:
> hwmod: Add AM33XX HWMOD data). Anybody care to ack this one?

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
