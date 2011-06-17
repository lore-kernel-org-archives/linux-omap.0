From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v5 15/18] ASoC: twl6040: Remove pll and
	headset mode dependency
Date: Fri, 17 Jun 2011 14:27:59 +0100
Message-ID: <20110617132759.GB4951@sirena.org.uk>
References: <1307983070-2257-1-git-send-email-peter.ujfalusi@ti.com> <1307983070-2257-16-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307983070-2257-16-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 13, 2011 at 07:37:47PM +0300, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> Remove dependency between pll (hppll, lppll) and headset power
> mode (low-power, high-performance), as headset power mode can
> be used with any pll.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but...

> A new control is created to allow headset power mode configuration
> from userspace. Changing headset power mode during earpiece related
> usecases is not allowed as earpiece requires HS DAC in HP mode.

Might be nicer to allow the user to set the control given that you'll
just ignore the configured value anyway if it's not usable right now.
