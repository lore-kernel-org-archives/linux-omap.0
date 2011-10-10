From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] omap: sound: fix checkpatch.pl error
Date: Mon, 10 Oct 2011 09:56:36 +0300
Message-ID: <4E929724.4070708@bitmer.com>
References: <1318223228-15671-1-git-send-email-michael.opdenacker@linaro.org>
	<1318223228-15671-3-git-send-email-michael.opdenacker@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1318223228-15671-3-git-send-email-michael.opdenacker@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Opdenacker <michael.opdenacker@linaro.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

On 10/10/2011 08:07 AM, Michael Opdenacker wrote:
> Signed-off-by: Michael Opdenacker<michael.opdenacker@linaro.org>
> ---
>   sound/soc/omap/omap-mcbsp.c |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 1391ea0..30325fb 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -606,8 +606,7 @@ static int mcbsp_dai_probe(struct snd_soc_dai *dai)
>   	return 0;
>   }
>
> -static struct snd_soc_dai_driver omap_mcbsp_dai =
> -{
> +static struct snd_soc_dai_driver omap_mcbsp_dai = {

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
