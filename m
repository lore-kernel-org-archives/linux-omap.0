From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCHv2 1/4] MFD: palmas PMIC device support
Date: Fri, 18 May 2012 11:55:12 +0200
Message-ID: <20120518095512.GF12015@sortiz-mobl>
References: <1337064539-3014-1-git-send-email-gg@slimlogic.co.uk>
 <1337064539-3014-2-git-send-email-gg@slimlogic.co.uk>
 <20120515181448.GD19592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120515181448.GD19592@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, linux-kernel@vger.kernel.org, lrg@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Tue, May 15, 2012 at 07:14:51PM +0100, Mark Brown wrote:
> On Tue, May 15, 2012 at 03:48:56PM +0900, Graeme Gregory wrote:
> > Palmas is a PMIC from Texas Instruments and this is the MFD part of the
> > driver for this chip. The PMIC has SMPS and LDO regulators, a general
> > purpose ADC, GPIO, USB OTG mode detection, watchdog and RTC features.
> 
> Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> however this depends on some new regmap-irq changes that Graeme posted a
> couple of days ago and are only on regmap at the minute - Samuel, if
> you're OK with this I guess the easiest thing is if I apply there?
I'm fine with it. For the MFD parts:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
