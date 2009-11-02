From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] MFD: twl4030-codec: APLL_INFREQ
 handling in the MFD driver
Date: Mon, 2 Nov 2009 17:30:35 +0000
Message-ID: <20091102173035.GC8546@rakim.wolfsonmicro.main>
References: <1257165295-9352-1-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-2-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-3-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1257165295-9352-4-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 02, 2009 at 02:34:53PM +0200, Peter Ujfalusi wrote:
> Move the APLL_CTL register configuration to the twl4030-codec
> MFD driver.
> Provide also a function for childs to query the audio_mclk
> frequency.

This all looks good to me, some nitpicks below.

> +unsigned int twl4030_codec_get_mclk(void)
> +{
> +	struct twl4030_codec *codec = platform_get_drvdata(twl4030_codec_dev);
> +
> +	return codec->audio_mclk;
> +}
> +EXPORT_SYMBOL_GPL(twl4030_codec_get_mclk);

As I said in my followup to patch 5 this feels like it should have a
parameter to specify the twl4030 though in practical systems it won't
matter.

> +	if (!(pdata->audio_mclk == 19200000 ||
> +	      pdata->audio_mclk == 26000000 ||
> +	      pdata->audio_mclk == 38400000)) {
> +		dev_err(&pdev->dev, "Invalid audio_mclk\n");
> +		return -EINVAL;
> +	}

Might flow more naturally with a switch statement?
