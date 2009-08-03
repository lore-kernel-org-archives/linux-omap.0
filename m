From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Mon, 3 Aug 2009 11:29:50 +0300
Message-ID: <20090803112950.3fb6cda9.jhnikula@gmail.com>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200908030332.06727.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, e3-hacking@earth.li, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Mon, 3 Aug 2009 03:32:04 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> This patch tries to correct the problem of full duplex mode not working
> over a single McBSP based CPU DAI.
> 
> Created against linux-2.6.31-rc5.
> Tested on Amstrad Delta.
> 
Do you have some specific test case how to trigger this? I haven't
seen this on 2420 or 34xx (e.g. with 'arecord -d 1 -f dat |aplay') but
I have no doubt that this can happen on 1510. At least this doesn't
cause any harm on Beagle so I'm fine with the fix.

> @@ -191,6 +192,14 @@ static int omap_mcbsp_dai_trigger(struct
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		if (!mcbsp_data->active++)
>  			omap_mcbsp_start(mcbsp_data->bus_id);
> +		else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			/* looks like capture already in progress,
> +			 * start playback by taking it out of error condition */
> +			omap_mcbsp_pollwrite(mcbsp_data->bus_id, 0x0);
> +		else
> +			/* looks like playback already in progress,
> +			 * start capture by taking it out of error condition */
> +			omap_mcbsp_pollread(mcbsp_data->bus_id, &buf);
>  		break;
Minor note: See preferred style for multi-line comments in
Documentation/CodingStyle. I'm not 100 % sure about the braces but I
think they are also preferred if there are indented comment lines with
the single code line.


-- 
Jarkko
