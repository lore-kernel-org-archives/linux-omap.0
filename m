From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v6 1/6] ALSA: pcm: add IEC958 channel
 status helper for hw_params
Date: Wed, 9 Mar 2016 11:08:54 +0100
Message-ID: <56DFF636.9090304@st.com>
References: <cover.1457465383.git.jsarha@ti.com>
 <3d9fbdac702b93742841221e3e8d2468a3d18f12.1457465383.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <3d9fbdac702b93742841221e3e8d2468a3d18f12.1457465383.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hello Jyri,

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

With few nitpicking remarks on form.

Regards
Arnaud

On 03/08/2016 09:14 PM, Jyri Sarha wrote:
> Add IEC958 channel status helper that gets the audio properties from
> snd_pcm_hw_params instead of snd_pcm_runtime. This is needed to
> produce the channel status bits already in audio stream configuration
> phase.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  include/sound/pcm_iec958.h |  2 ++
>  sound/core/pcm_iec958.c    | 53 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
> index 0eed397..36f023a 100644
> --- a/include/sound/pcm_iec958.h
> +++ b/include/sound/pcm_iec958.h
> @@ -6,4 +6,6 @@
>  int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
>  	size_t len);
>  
> +int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
> +					     u8 *cs, size_t len);
>  #endif
> diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
> index 36b2d7a..27e0981 100644
> --- a/sound/core/pcm_iec958.c
> +++ b/sound/core/pcm_iec958.c
> @@ -9,30 +9,18 @@
>  #include <linux/types.h>
>  #include <sound/asoundef.h>
>  #include <sound/pcm.h>
> +#include <sound/pcm_params.h>
>  #include <sound/pcm_iec958.h>
>  
> -/**
> - * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
> - * @runtime: pcm runtime structure with ->rate filled in
> - * @cs: channel status buffer, at least four bytes
> - * @len: length of channel status buffer
> - *
> - * Create the consumer format channel status data in @cs of maximum size
> - * @len corresponding to the parameters of the PCM runtime @runtime.
> - *
> - * Drivers may wish to tweak the contents of the buffer after creation.
> - *
> - * Returns: length of buffer, or negative error code if something failed.
> - */
> -int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> -	size_t len)
> +static int create_iec958_consumer(uint rate, uint sample_width,
> +				  u8 *cs, size_t len)
>  {
>  	unsigned int fs, ws;
>  
>  	if (len < 4)
>  		return -EINVAL;
>  
> -	switch (runtime->rate) {
> +	switch (rate) {
>  	case 32000:
>  		fs = IEC958_AES3_CON_FS_32000;
>  		break;
> @@ -59,7 +47,7 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
>  	}
>  
>  	if (len > 4) {
> -		switch (snd_pcm_format_width(runtime->format)) {
> +		switch (sample_width) {
>  		case 16:
>  			ws = IEC958_AES4_CON_WORDLEN_20_16;
>  			break;
> @@ -71,6 +59,7 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
>  			     IEC958_AES4_CON_MAX_WORDLEN_24;
>  			break;
>  		case 24:
> +		case 32: /* Assume 24-bit width for 32-bit samples. */
>  			ws = IEC958_AES4_CON_WORDLEN_24_20 |
>  			     IEC958_AES4_CON_MAX_WORDLEN_24;
>  			break;
> @@ -92,4 +81,34 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
>  
>  	return len;
>  }
> +
> +/**
> + * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
> + * @runtime: pcm runtime structure with ->rate filled in
> + * @cs: channel status buffer, at least four bytes
> + * @len: length of channel status buffer
> + *
> + * Create the consumer format channel status data in @cs of maximum size
> + * @len corresponding to the parameters of the PCM runtime @runtime.
> + *
> + * Drivers may wish to tweak the contents of the buffer after creation.
> + *
> + * Returns: length of buffer, or negative error code if something failed.
> + */
> +int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> +	size_t len)
should be aligned on parenthesis
> +{
> +	return create_iec958_consumer(runtime->rate,
> +				      snd_pcm_format_width(runtime->format),
> +				      cs, len);
> +}
>  EXPORT_SYMBOL(snd_pcm_create_iec958_consumer);
> +
> +
No kernel-doc comment?
> +int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
Could be snd_pcm_hw_params_create_iec958_consumer to be coherent with
functions declared in pcm.h
> +					     u8 *cs, size_t len)
should be aligned on parenthesis
> +{
> +	return create_iec958_consumer(params_rate(params), params_width(params),
> +				      cs, len);
> +}
> +EXPORT_SYMBOL(snd_pcm_create_iec958_consumer_hw_params);
> 
