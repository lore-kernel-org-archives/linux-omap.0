From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/8] MFD: twl4030-audio: Rename platform
	data
Date: Fri, 3 Jun 2011 11:08:22 +0300
Message-ID: <20110603080819.GK8696@atomide.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
	<201106011617.14854.peter.ujfalusi@ti.com>
	<20110601133823.GI11352@atomide.com>
	<201106020915.46491.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <201106020915.46491.peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110602 09:11]:
> On Wednesday 01 June 2011 16:38:23 Tony Lindgren wrote:
> > But you could easily remove all the board specific struct
> > twl4030_codec_data and struct twl4030_codec_audio_data entries by adding a
> > default audio init option to omap_pmic_init for the common configuration.
> 
> Yeah, I can grep in the board files, and see what is the most common 
> configuration
> 
> > How about something like:
> > 
> > void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int
> > pmic_irq, struct twl4030_platform_data *pmic_data, u32 flags);
> 
> common-board-devices.c has omap_pmic_init, but without the flags.
> 
> > Where flags would be TWL_BOARD_HAS_DEFAULT_CODEC etc, and if the entry in
> > pmic_data is NULL, just use the default configuration. I think you already
> > have the clkrate there?
> 
> I'll take a look, should we have new file specifically for twl, or should I 
> extend the common-board-devices.c with the twl related things? IMHO a new file 
> might be better, since the full twl config might be quite big.

Yeah if it gets big then a separate file is better. Also, if we have
a common init function for twl, then it's easy to add the board specific
device tree initialization to that too and just leave out the calls to
omap_pmic_init from board-*.c files.

Regards,

Tony
