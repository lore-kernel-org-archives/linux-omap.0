From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 10:55:25 -0800
Message-ID: <20180115185525.GA4042@atomide.com>
References: <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
 <20180115175220.GK4821@atomide.com>
 <20180115175626.GC12018@sirena.org.uk>
 <20180115180626.GL4821@atomide.com>
 <20180115181352.GD12018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115181352.GD12018@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180115 18:14]:
> On Mon, Jan 15, 2018 at 10:06:26AM -0800, Tony Lindgren wrote:
> > * Mark Brown <broonie@kernel.org> [180115 17:56]:
> 
> > > Sorry, I didn't actually post it - just suggested adding the
> > > snd_soc_codec_set_regmap() call.
> 
> > Oh I see. Yeah that seems like a good long term solution after
> > the regressions are fixed.
> 
> I would like to see us do that sooner rather than later assuming it
> addresses the issue, it's quicker and simpler.

Peter, can you take a look at that?

Meanwhile, here's a regression fix for Linux next for twl4030
and 6040 drivers.

Regards,

Tony

8< ---------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 12 Jan 2018 10:24:36 -0800
Subject: [PATCH] ASoC: Fix twl4030 and 6040 regression by adding back read
 and write

Commit 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read on twl4030")
caused regressions for both twl4030 and twl6040 as it assumes the
ASoC driver is using regmap. As a side effect, this also causes a
considerable increase in idle power consumption omap3 boards using
twl4030 as the PMIC.

This is because the removal of read and write function pointers
causes some of the ASoC IO functions to not do anything. For example,
snd_soc_register_card() calls snd_soc_dapm_new_widgets() that calls
snd_soc_codec_drv_read() that now does nothing.

A long term solution suggested by Mark Brown <broonie@kernel.org>
is to make the twl drivers use regmap by adding a call to
snd_soc_codec_set_regmap(). This however needs more consideration
as currently the driver internal reads do caching and we would have
both regmap access and internal read/write access accessing the same
hardware registers.

So to fix the regression, let's just do a partial revert adding back
the read and write function pointers. Note that other non-regmap
ASoC drivers may need similar patches.

Fixes: 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read on twl4030")
Fixes: 93a00c467fe9 ("ASoC: don't use snd_soc_write/read on twl6040")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/codecs/twl4030.c | 2 ++
 sound/soc/codecs/twl6040.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2195,6 +2195,8 @@ static int twl4030_soc_remove(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.probe = twl4030_soc_probe,
 	.remove = twl4030_soc_remove,
+	.read = twl4030_read,
+	.write = twl4030_write,
 	.set_bias_level = twl4030_set_bias_level,
 	.idle_bias_off = true,
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1158,6 +1158,8 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.probe = twl6040_probe,
 	.remove = twl6040_remove,
+	.read = twl6040_read,
+	.write = twl6040_write,
 	.set_bias_level = twl6040_set_bias_level,
 	.suspend_bias_off = true,
 	.ignore_pmdown_time = true,
-- 
2.15.0
