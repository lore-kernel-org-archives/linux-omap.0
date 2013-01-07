From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: am33xx-hwmod: Fix wrongly terminated
 am33xx_usbss_mpu_irqs array
Date: Mon, 7 Jan 2013 12:40:18 -0800
Message-ID: <20130107204017.GK14149@atomide.com>
References: <1357252342-6166-1-git-send-email-panto@antoniou-consulting.com>
 <20130107200338.GD14149@atomide.com>
 <alpine.DEB.2.00.1301072009170.31833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301072009170.31833@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [130107 12:12]:
> On Mon, 7 Jan 2013, Tony Lindgren wrote:
> 
> > * Pantelis Antoniou <panto@antoniou-consulting.com> [130103 14:35]:
> > > The IRQ array must be terminated by -1 and not by -1+OMAP_INTC_START
> > > This led to having a resource list of 100s of IRQs.
> > 
> > This is a bug for sure introduced with commit a2cfc509 (ARM: OMAP3+:
> > hwmod: Add AM33XX HWMOD data). Anybody care to ack this one?
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Thanks applying into omap-for-v3.8-rc2/fixes.

Regards,

Tony
