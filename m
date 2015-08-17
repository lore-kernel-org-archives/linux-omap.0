From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v3 3/7] ASoC: hdmi-codec: Add
 hdmi-codec for external HDMI-encoders
Date: Mon, 17 Aug 2015 09:50:53 +0300
Message-ID: <55D1844D.1060806@ti.com>
References: <cover.1439542916.git.jsarha@ti.com>
 <ed41a6c0b594866c05e695cc066371d0e3862c7e.1439542916.git.jsarha@ti.com>
 <20150814095741.GG7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150814095741.GG7576@n2100.arm.linux.org.uk>
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

On 08/14/15 12:57, Russell King - ARM Linux wrote:
> On Fri, Aug 14, 2015 at 12:30:41PM +0300, Jyri Sarha wrote:
>> +static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
>> +				struct snd_pcm_hw_params *params,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
>> +	struct hdmi_codec_params hp = {
>> +		.cea = { 0 },
>
> Unnecessary initialisation - because you are initialising this structure,
> all unnamed fields will be zeroed.
>

True, I just tried to be explicit.

>> +		.iec = {
>> +			.status = {
>> +				IEC958_AES0_CON_NOT_COPYRIGHT,
>> +				IEC958_AES1_CON_GENERAL,
>> +				IEC958_AES2_CON_SOURCE_UNSPEC,
>> +				IEC958_AES3_CON_CLOCK_VARIABLE,
>> +			},
>
> ...
>
>> +	hdmi_audio_infoframe_init(&hp.cea);
>> +	hp.cea.coding_type = HDMI_AUDIO_CODING_TYPE_PCM;
>
> Something tells me here that you haven't read the HDMI specification.
> HDMI says that the coding type will be zero (refer to stream header).
> The same goes for much of the CEA audio infoframe.  Please see the
> Audio InfoFrame details in the HDMI specification.
>

Must admit, that I have not read it end to end. Obviously I have missed 
a relevant piece of information here. I'll fix that and check the 
related items too.

>> +	hp.cea.channels = params_channels(params);
>> +
>> +	switch (params_width(params)) {
>> +	case 16:
>> +		hp.iec.status[4] |= IEC958_AES4_CON_WORDLEN_20_16;
>> +		hp.cea.sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
>> +		break;
>> +	case 18:
>> +		hp.iec.status[4] |= IEC958_AES4_CON_WORDLEN_22_18;
>> +		hp.cea.sample_size = HDMI_AUDIO_SAMPLE_SIZE_20;
>> +		break;
>> +	case 20:
>> +		hp.iec.status[4] |= IEC958_AES4_CON_WORDLEN_24_20;
>> +		hp.cea.sample_size = HDMI_AUDIO_SAMPLE_SIZE_20;
>> +		break;
>> +	case 24:
>> +	case 32:
>> +		hp.iec.status[4] |= IEC958_AES4_CON_MAX_WORDLEN_24 |
>> +			IEC958_AES4_CON_WORDLEN_24_20;
>
> Why not use the generic code to generate the AES channel status bits?
> See sound/core/pcm_iec958.c.
>

Thanks, I did not know that exist. I'll make use of that.

Best regards,
Jyri
