From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v3 2/4] mfd: introduce retu-mfd driver
Date: Tue, 20 Nov 2012 10:38:18 -0800
Message-ID: <20121120183815.GL18567@atomide.com>
References: <1352747326-2195-1-git-send-email-aaro.koskinen@iki.fi>
 <1352747326-2195-3-git-send-email-aaro.koskinen@iki.fi>
 <20121120183427.GK18567@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121120183427.GK18567@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [121120 10:36]:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [121112 11:11]:
> > Retu is a multi-function device found on Nokia Internet Tablets
> > implementing at least watchdog, RTC, headset detection and power button
> > functionality.
> > 
> > This patch implements minimum functionality providing register access,
> > IRQ handling and power off functions.
> 
> Samuel, you can pick this one up separately now that Wolfram has taken
> the i2c-cbus driver.
> 
> Also, just noticed that this probably should depend on I2C_CBUS as this
> chip will not communicate over other I2C adapters?

Sorry meant to reply to "[PATCH v4 2/4] mfd: introduce retu-mfd driver"
instead of this v3 thread.

Regards,

Tony
