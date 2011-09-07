From: Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ASoC: omap: add MODULE_ALIAS to mcbsp and pcm drivers
Date: Wed, 07 Sep 2011 12:29:58 +0300
Message-ID: <4E673996.1090401@bitmer.com>
References: <1315340056-32148-1-git-send-email-mans.rullgard@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1315340056-32148-1-git-send-email-mans.rullgard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mans Rullgard <mans.rullgard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

On 09/06/2011 11:14 PM, Mans Rullgard wrote:
> This adds MODULE_ALIAS directives to the omap-mcbsp-dai and
> omap-pcm-audio drivers so they can be auto-loaded when platform
> devices are scanned.
>
> Signed-off-by: Mans Rullgard<mans.rullgard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   sound/soc/omap/omap-mcbsp.c |    2 ++
>   sound/soc/omap/omap-pcm.c   |    2 ++
>   2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 07b7723..56b7504 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -758,6 +758,8 @@ static int __devexit asoc_mcbsp_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +MODULE_ALIAS("platform:omap-mcbsp-dai");
> +
Put these at the end of file where the other MODULE_ macros are.

Send updated patch to alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org with Liam Girdwood and 
Mark Brown cc'ed (see SOUND - SOC LAYER in ./MAINTAINERS).

-- 
Jarkko
