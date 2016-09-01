From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: off-by-one in
 'omap_pcm_limit_supported_formats'
Date: Thu, 1 Sep 2016 09:59:29 +0300
Message-ID: <0bb8879b-84d0-f871-7b36-f8c9b4b0b560@ti.com>
References: <1472712757-21066-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1472712757-21066-1-git-send-email-christophe.jaillet@wanadoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jarkko.nikula@bitmer.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/01/16 09:52, Christophe JAILLET wrote:
> When calling 'snd_pcm_format_physical_width', SNDRV_PCM_FORMAT_LAST is a
> valid value, so don't skip it.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Un-tested
> ---
>  sound/soc/omap/omap-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index a84f677234f0..94e9ff791f3a 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -58,7 +58,7 @@ static void omap_pcm_limit_supported_formats(void)
>  {
>  	int i;
>  =

> -	for (i =3D 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
> +	for (i =3D 0; i <=3D SNDRV_PCM_FORMAT_LAST; i++) {
>  		switch (snd_pcm_format_physical_width(i)) {
>  		case 8:
>  		case 16:
> =



-- =

P=E9ter
