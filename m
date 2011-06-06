From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
Date: Mon, 6 Jun 2011 12:53:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B7B69A6@dbde02.ent.ti.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
 <4DEC7B6D.6060901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DEC7B6D.6060901@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Monday, June 06, 2011 12:32 PM
> To: Colin Cross
> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Russell King; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
> 
> On 6/5/2011 12:33 AM, Colin Cross wrote:
> > Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
> > causing only the last bit set to take effect, resulting in lost
> > wakeups when the GPIO controller is in idle.
> >
> > Replace direct writes to IRQWAKEN with writes to SETWKUENA and
> > CLEARWKUEN.
> >
> > Signed-off-by: Colin Cross<ccross@android.com>
> 
> Looks good. This needs to be fixed on top of the clean-up
> branch where GPIO movemnt to driver/gpio/* happening.
> 
> For this change,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
This is also available as part of following cleanup series we are doing.
However, since this is a defect we can prioritize it over the cleanup.
--
Tarun
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
