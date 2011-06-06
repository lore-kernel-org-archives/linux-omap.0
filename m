From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/8] MFD: twl4030-audio: Rename platform data
Date: Mon, 6 Jun 2011 12:55:40 +0300
Message-ID: <20110606095540.GR8696@atomide.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
 <201106020915.46491.peter.ujfalusi@ti.com>
 <20110603080819.GK8696@atomide.com>
 <201106031638.26094.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201106031638.26094.peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110603 16:34]:
> On Friday 03 June 2011 11:08:22 Tony Lindgren wrote:
> > Yeah if it gets big then a separate file is better. Also, if we have
> > a common init function for twl, then it's easy to add the board specific
> > device tree initialization to that too and just leave out the calls to
> > omap_pmic_init from board-*.c files.
> 
> I have parsed the board files for a pattern.
> There are some, but I have my doubts as well:
> We have eight platform data members in twl4030_platform_data for child 
> devices.
> USB, and audio/codec configuration might worth to move out (since most of the 
> board does not have fine tuned parameters for codec).
> 
> The majority of the code related to pmic is coming from regulator setups, I 
> can see similarities, but there are differences here and there, which makes 
> the common configuration mostly useless (different peripherals, boot loader 
> diffs, etc).

Yeah we still need the board specific data passed for sure.
 
> Having said that, I try to create a wrapper for omap_pmic_init, which can 
> replace the current omap2/3/4_pmic_init, with that we can use common config 
> for USB, audio, and some selected few regulators initially.
> Later other parts might be possible to consolidate as well.
> I'm going to call this new wrapper for now omap2/3/4_pmic_config.
> 
> Is this a good way to approach this issue?

Sounds good to me!

Tony
