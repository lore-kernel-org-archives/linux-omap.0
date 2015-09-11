From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH RFC 1/5] ASoC: davinci-mcasp: Set
 .symmetric_rates = 1 in snd_soc_dai_driver
Date: Fri, 11 Sep 2015 11:48:00 +0300
Message-ID: <55F29540.40002@ti.com>
References: <cover.1441806963.git.jsarha@ti.com>
 <2ada475a3e0243b093a958e8bb5c465e8fb08abf.1441806963.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2ada475a3e0243b093a958e8bb5c465e8fb08abf.1441806963.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: liam.r.girdwood@linux.intel.com, Li.Xiubo@freescale.com, misael.lopez@ti.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 09/09/2015 09:27 PM, Jyri Sarha wrote:
> The TX and RX direction share the same bit clock and frame sync, so
> the samplerate must be the same to both directions.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index fa0511b..bbd1987 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1304,6 +1304,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[=
] =3D {
>  		.ops 		=3D &davinci_mcasp_dai_ops,
>  =

>  		.symmetric_samplebits	=3D 1,
> +		.symmetric_rates	=3D 1,
>  	},
>  	{
>  		.name		=3D "davinci-mcasp.1",
> =



-- =

P=E9ter
