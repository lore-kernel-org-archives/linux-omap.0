From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6 15/18] ASoC: twl6040: Remove pll and headset mode
 dependency
Date: Tue, 21 Jun 2011 18:35:05 +0100
Message-ID: <20110621173505.GC26592@opensource.wolfsonmicro.com>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com>
 <1308663556-29120-16-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308663556-29120-16-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 21, 2011 at 04:39:13PM +0300, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> Remove dependency between pll (hppll, lppll) and headset power
> mode (low-power, high-performance), as headset power mode can
> be used with any pll.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but you should note that the code has been modified since Misael's
original version.
