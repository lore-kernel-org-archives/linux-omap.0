From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 8 Aug 2012 13:52:52 +0100
Message-ID: <20120808125252.GR16861@opensource.wolfsonmicro.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <5022529D.3090406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5022529D.3090406@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 08, 2012 at 01:50:53PM +0200, Benoit Cousson wrote:

> That being said, since we do have the clock binding now, maybe we should
> create a clock provider at board level for the sys_clk and thus you will
> just have to create a phandle to it in your audio description.

Yes, we should be doing this.
