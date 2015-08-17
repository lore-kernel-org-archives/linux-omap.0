From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v3 6/7] drm/i2c: tda998x: Register ASoC
 HDMI codec for audio functionality
Date: Mon, 17 Aug 2015 10:25:23 +0300
Message-ID: <55D18C63.1010401@ti.com>
References: <cover.1439542916.git.jsarha@ti.com>
 <1e8e3215caa932dab68de8576aee81f5e1008163.1439542916.git.jsarha@ti.com>
 <20150814100616.GH7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150814100616.GH7576@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, moinejf@free.fr, airlied@linux.ie, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/14/15 13:06, Russell King - ARM Linux wrote:
> On Fri, Aug 14, 2015 at 12:30:44PM +0300, Jyri Sarha wrote:
>> +static int tda998x_write_aif(struct tda998x_priv *priv,
>> +			     struct hdmi_audio_infoframe *cea)
>> +{
>> +	uint8_t buf[HDMI_INFOFRAME_SIZE(AUDIO)];
>> +	int len;
>> +
>> +	len = hdmi_audio_infoframe_pack(cea, buf, sizeof(buf));
>> +	if (len < 0) {
>> +		dev_err(&priv->hdmi->dev,
>> +			"Failed to pack audio infoframe: %d\n", len);
>> +		return len;
>> +	}
>> +
>> +	/* Write the audio information packet */
>> +	tda998x_write_if(priv, DIP_IF_FLAGS_IF4, REG_IF4_HB0, buf, len);
>> +	return 0;
>> +}
>> +
>
> I have such a function already queued up, but I can't push it out at the
> moment because of too many conflicts across all my DRM work.  I'm waiting
> for after 4.3-rc1 before publishing anything from or accepting anything
> else into DRM branches.
>

Ok, is the code available some where? Could take a look so I can align 
my code to that.

>>   static void
>>   tda998x_write_avi(struct tda998x_priv *priv, struct drm_display_mode *mode)
>>   {
>> @@ -670,19 +691,24 @@ static void tda998x_audio_mute(struct tda998x_priv *priv, bool on)
>>   	}
>>   }
>>
>> -static void
>> +static int
>>   tda998x_configure_audio(struct tda998x_priv *priv,
>> -		struct drm_display_mode *mode, struct tda998x_encoder_params *p)
>> +			int mode_clock,
>> +			int ena_ap,
>> +			int dai_format,
>> +			int sample_width,
>> +			int sample_rate,
>> +			const u8 *status)
>
> I don't think this is an improvement.
>

Still it makes the function more generic and enables its usage in 
HDMI-codec API implementation. I'll try to make it look tidier.

>> +static int tda998x_audio_get_eld(struct device *dev, uint8_t *buf, size_t len)
>> +{
>> +	struct tda998x_priv *priv = dev_get_drvdata(dev);
>> +	struct drm_mode_config *config = &priv->encoder->dev->mode_config;
>> +	struct drm_connector *connector;
>> +	int ret = -ENODEV;
>> +
>> +	mutex_lock(&config.mutex);
>> +	list_for_each_entry(connector, &config->connector_list, head) {
>> +		if (priv->encoder == connector->encoder) {
>> +			memcpy(buf, connector->eld,
>> +			       min(sizeof(connector->eld), len));
>> +			ret = 0;
>> +		}
>> +	}
>> +	mutex_unlock(&config.mutex);
>
> Obviously untested.  Should be config->mutex.
>

Sorry. Should never do these last minute changes. I must have been 
compiling and testing different code version. I first had this function 
using config->connection_mutex, but then - after reading the eld related 
code - found that mode_config mutex should be used instead.

> But in any case, when I kill the DRM slave encoder code in here, this
> becomes unnecessary.
>

Ok, The information from ELD needs be passed to audio side constraints 
somehow. I'd love to see the code you have in queue.

Best regards,
Jyri
