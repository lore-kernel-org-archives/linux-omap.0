From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] ASoC: omap: Deprecate omap-pcm for
 sdma-pcm
Date: Wed, 25 Apr 2018 09:56:21 -0700
Message-ID: <20180425165621.GZ5671@atomide.com>
References: <20180425061837.14145-1-peter.ujfalusi@ti.com>
 <20180425101044.GA17531@bitmer.com>
 <20180425135012.GW5671@atomide.com>
 <f2033207-f750-42fb-649f-095591f90026@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <f2033207-f750-42fb-649f-095591f90026@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [180425 16:06]:
> On 04/25/2018 04:50 PM, Tony Lindgren wrote:
> > * Jarkko Nikula <jarkko.nikula@bitmer.com> [180425 03:56]:
> >> What I noticed some time ago on N810 but not time to fix it that OMAP mux
> >> change dropped muxing audio McBSP pins. Those pins are muxed by reset or
> >> bootloader to another function.
> >>
> >> Probably a few lines to arch/arm/boot/dts/omap2420-n810.dts etc.
> > 
> > Hmm do you have a link or commit id to a patch that does the muxing
> > to see which pins need to be muxed?
> 
> FWIW I have this at the moment:
> https://pastebin.com/WNT9wnD5
> 
> I see that the card is there, but I'm fighting buildroot to have nfs
> filesystem with aplay :o
> 
> There are few things going to be needed to get things in a shape, like
> converting the sound/soc/omap/n810.c to platform driver to be probed via DT.
> Proper bindings for the card,
> support for mclk handling in aic3x codec driver (n810 is hackinig that in the
> machine driver)
> 
> In theory audio _should_ work with the DT changes and the fixup in the n810.c...
> 
> Should...

Cool. The pinctrl fixes at least make sense to me, that could be
a separate patch maybe with Fixes: 5a87cde490e1 ("ARM: OMAP2+: Remove
legacy booting support for n8x0") as pointed out by Jarkko.

Regards,

Tony
