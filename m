From: Dave Airlie <airlied@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 0/5] Beaglebone-Black HDMI audio
Date: Wed, 17 Sep 2014 11:06:53 +1000
Message-ID: <CAPM=9txRReSdcB5j+0dKmrDNM94zANu-q7ZfWHtP2iA54Dieig@mail.gmail.com>
References: <cover.1410898073.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1410898073.git.jsarha@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, t-kristo@ti.com, dri-devel <dri-devel@lists.freedesktop.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, bcousson@baylibre.com, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 17 September 2014 06:40, Jyri Sarha <jsarha@ti.com> wrote:
> Changes since v2:
> - Change compatible property from "ti,gpio-clock" to "ti,gpio-gate-clock"
> - Some minor cleanups
>
> The code has a functional dependency to:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg109264.html
>
> Without the above patch the audio card does not probe.
>
> The code has been rebased on top of Linux 3.17-rc5. The patches
> bellow, the above dependency, and couple of commits to add BBB HDMI audio
> support to omap2plus_defconfig can be pulled from:
>
> https://github.com/jsarha/linux.git linux-master-bbb-hdmi-audio

How do you intend to get this merge, sending patchsets like this without
indication to maintainers on a merge strategy is kinda messy.

I'm not sure how maintained tilcdc is.

Dave.
>
> Cheers,
> Jyri
>
> Jyri Sarha (5):
>   clk: ti: add "ti,gpio-gate-clock" controlled clock
>   drm/tilcdc: Add I2S HDMI audio config for tda998x
>   ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
>     bus
>   ASoC: davinci: HDMI audio build for AM33XX and TDA998x
>   ARM: dts: am335x-boneblack: Add HDMI audio support
>
>  .../bindings/clock/ti/gpio-gate-clock.txt          |   21 ++
>  .../bindings/sound/davinci-evm-audio.txt           |    6 +-
>  arch/arm/boot/dts/am335x-boneblack.dts             |   52 +++++
>  drivers/clk/ti/Makefile                            |    2 +-
>  drivers/clk/ti/gpio.c                              |  202 ++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
>  sound/soc/davinci/Kconfig                          |   12 ++
>  sound/soc/davinci/davinci-evm.c                    |   82 +++++++-
>  8 files changed, 395 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/gpio-gate-clock.txt
>  create mode 100644 drivers/clk/ti/gpio.c
>
> --
> 1.7.9.5
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
