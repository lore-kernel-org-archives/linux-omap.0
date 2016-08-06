From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/3] drm/i2c: tda998x: Improve
 tda998x_configure_audio() audio related pdata
Date: Sat, 6 Aug 2016 18:56:35 +0100
Message-ID: <20160806175634.GT5783@n2100.arm.linux.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <5adcd94104080abcd5b072a5d6a85b85c5ea0584.1470129989.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <5adcd94104080abcd5b072a5d6a85b85c5ea0584.1470129989.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, airlied@linux.ie, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 02, 2016 at 03:05:07PM +0300, Jyri Sarha wrote:
> @@ -41,7 +41,7 @@ struct tda998x_priv {
>  	u8 vip_cntrl_0;
>  	u8 vip_cntrl_1;
>  	u8 vip_cntrl_2;
> -	struct tda998x_encoder_params params;
> +	struct tda998x_audio_params audio_params;
...
> @@ -820,7 +819,7 @@ static void tda998x_encoder_set_config(struct tda998x_priv *priv,
>  			    VIP_CNTRL_2_SWAP_F(p->swap_f) |
>  			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
>  
> -	priv->params = *p;
> +	priv->audio_params = p->audio;
...
> @@ -15,16 +28,7 @@ struct tda998x_encoder_params {
>  	u8 swap_e:3;
>  	u8 mirr_e:1;
>  
> -	u8 audio_cfg;
> -	u8 audio_clk_cfg;
> -	u8 audio_frame[6];
> -
> -	enum {
> -		AFMT_SPDIF,
> -		AFMT_I2S
> -	} audio_format;
> -
> -	unsigned audio_sample_rate;
> +	struct tda998x_audio_params audio;

Another point - it would be nice if the name for both tda998x_audio_params
structures was the same.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
