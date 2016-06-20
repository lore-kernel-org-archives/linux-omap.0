From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] ASoC: tpa6130a2: Add DAPM support
Date: Mon, 20 Jun 2016 11:34:48 +0300
Message-ID: <9e2aa325-b800-f2f0-6f56-0bf07644f689@ti.com>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
 <2aed60529eea206f2192a7236f2d80386a73f2ee.1466218805.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2aed60529eea206f2192a7236f2d80386a73f2ee.1466218805.git.helen.koike@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Helen Koike <helen.koike@collabora.co.uk>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/18/2016 07:42 AM, Helen Koike wrote:
> Add DAPM support and updated rx51 accordingly.
> As a consequence:
> - the exported function tpa6130a2_stereo_enable is not needed anymore
> - the mutex is dealt in the DAPM
> - the power state is tracked by the DAPM
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> [koike: port for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
> ---
>  sound/soc/codecs/tpa6130a2.c | 184 +++++++++++++++++--------------------=
------
>  sound/soc/codecs/tpa6130a2.h |  11 +--
>  sound/soc/omap/rx51.c        |  22 ++----
>  3 files changed, 86 insertions(+), 131 deletions(-)
> =

> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index dc7bfc9..7cb5066 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -41,79 +41,71 @@ enum tpa_model {
>  	TPA6140A2,
>  };
>  =

> -static struct i2c_client *tpa6130a2_client;
> -
>  /* This struct is used to save the context */
>  struct tpa6130a2_data {
> -	struct mutex mutex;
>  	struct regmap *regmap;
>  	struct regulator *supply;
>  	int power_gpio;
> -	u8 power_state:1;
>  	enum tpa_model id;
>  };
>  =

> -static int tpa6130a2_power(u8 power)
> +static int tpa6130a2_power(struct device *dev, bool enable)

I would rather add 'struct device *dev' to tpa6130a2_data and pass the poin=
ter
to the private struct instead to the device.

>  {
> -	struct	tpa6130a2_data *data;
> -	int	ret =3D 0;
> -
> -	if (WARN_ON(!tpa6130a2_client))
> -		return -EINVAL;
> -	data =3D i2c_get_clientdata(tpa6130a2_client);
> -
> -	mutex_lock(&data->mutex);
> -	if (power =3D=3D data->power_state)
> -		goto exit;
> +	struct tpa6130a2_data *data =3D dev_get_drvdata(dev);
> +	int ret;
>  =

> -	if (power) {
> +	if (enable) {

-- =

P=E9ter
