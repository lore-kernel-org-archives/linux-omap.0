From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] ASoC: omap: Deprecate omap-pcm for
 sdma-pcm
Date: Wed, 25 Apr 2018 06:50:12 -0700
Message-ID: <20180425135012.GW5671@atomide.com>
References: <20180425061837.14145-1-peter.ujfalusi@ti.com>
 <20180425101044.GA17531@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180425101044.GA17531@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [180425 03:56]:
> What I noticed some time ago on N810 but not time to fix it that OMAP mux
> change dropped muxing audio McBSP pins. Those pins are muxed by reset or
> bootloader to another function.
> 
> Probably a few lines to arch/arm/boot/dts/omap2420-n810.dts etc.

Hmm do you have a link or commit id to a patch that does the muxing
to see which pins need to be muxed?

Regards,

Tony
