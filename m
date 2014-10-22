From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 09/12] rtc: omap: add support for pmic_power_en
Date: Wed, 22 Oct 2014 12:18:49 +0200
Message-ID: <20141022101849.GL2113@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-10-git-send-email-johan@kernel.org>
 <20141010180721.GV31348@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141010180721.GV31348@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, Lokesh Vutla <lokeshvutla@ti.com>, Guenter Roeck <linux@roeck-us.net>, Colin Foe-Parker <colin.foeparker@logicpd.com>, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 10, 2014 at 01:07:27PM -0500, Felipe Balbi wrote:
> On Thu, Oct 09, 2014 at 09:06:31PM +0200, Johan Hovold wrote:

> > -	/* clear pending irqs, and set 1/second periodic,
> > -	 * which we'll use instead of update irqs
> > +	/*
> > +	 * disable interrupts
> > +	 *
> > +	 * NOTE: ALARM2 is not cleared on AM3352 if rtc_write (writeb) is used
> >  	 */
> > -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> > +	rtc_writel(0, OMAP_RTC_INTERRUPTS_REG);
> 
> bug fix, should be part of a separate patch and Cc stable :-)

I made this a separate fix in v2 but did not mark it for stable for now
as no one has been bitten by it (ALARM2 is never enabled by the current
driver).

Johan
