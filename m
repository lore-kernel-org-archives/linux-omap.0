From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCHv2 1/1] Fix a Oops bug in omap soc driver.
Date: Fri, 19 Dec 2008 16:35:01 +0200
Message-ID: <20081219163501.0e235884.jarkko.nikula@nokia.com>
References: <4edcd8463d981e4babef82167aa58131539c367f.1229601269.git.stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4edcd8463d981e4babef82167aa58131539c367f.1229601269.git.stanley.miao@windriver.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Stanley.Miao" <stanley.miao@windriver.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 19 Dec 2008 22:08:22 +0800
"ext Stanley.Miao" <stanley.miao@windriver.com> wrote:

> There will be a Oops or frequent underrun messages when playing music with
> omap soc driver, this is because a data region is incorretly sized, other data
> region will be overwriten when writing to this data region.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  sound/soc/omap/omap-pcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index ce580a9..2adfbce 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -233,7 +233,7 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
>  	if (ret < 0)
>  		goto out;
>  
> -	prtd = kzalloc(sizeof(prtd), GFP_KERNEL);
> +	prtd = kzalloc(sizeof(struct omap_runtime_data), GFP_KERNEL);

Oh my... Can you change this as

	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);

like suggested by the CodingStyle and then you can have my ack.

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
