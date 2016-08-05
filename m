From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 1/3] drm/i2c: tda998x: Improve
 tda998x_configure_audio() audio related pdata
Date: Fri, 5 Aug 2016 12:02:27 +0300
Message-ID: <98a2279c-019d-7393-06a4-0b51c1229be5@ti.com>
References: <cover.1470129989.git.jsarha@ti.com>
 <5adcd94104080abcd5b072a5d6a85b85c5ea0584.1470129989.git.jsarha@ti.com>
 <20160804133135.GN5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160804133135.GN5783@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, airlied@linux.ie, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/04/16 16:31, Russell King - ARM Linux wrote:
> On Tue, Aug 02, 2016 at 03:05:07PM +0300, Jyri Sarha wrote:
>> @@ -787,19 +792,13 @@ tda998x_configure_audio(struct tda998x_priv *priv,
>>  	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
>>  
>>  	/* Write the channel status */
>> -	buf[0] = IEC958_AES0_CON_NOT_COPYRIGHT;
>> -	buf[1] = 0x00;
>> -	buf[2] = IEC958_AES3_CON_FS_NOTID;
>> -	buf[3] = IEC958_AES4_CON_ORIGFS_NOTID |
>> -			IEC958_AES4_CON_MAX_WORDLEN_24;
>> -	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
>> +	reg_write_range(priv, REG_CH_STAT_B(0), params->status, 4);
> 
> Take a close look at the code you are replacing here - the buffer
> contents is not AES bytes 0, 1, 2, 3, 4, but AES bytes 0, 1, 3, 4
> - byte 2 is not present in this array.  I don't think you've noticed
> this as your second patch merely copies verboten the IEC status:
> 
> +       memcpy(audio.status, params->iec.status,
> +              min(sizeof(audio.status), sizeof(params->iec.status)));
> 
> assuming that it is bytes 0-3.  Byte 2 is stored separately for each
> I2S channel in the following registers.
> 

Oh, yes. I missed that. I think it would be better to increase
tda998x_audio_params status buffer length by one and keep it otherwise
as it is. Then just write the bytes 0-1 and 3-4 separately into channel
status registers, with appropriate comments. I guess the the AES byte 2
can remain 0 for now (source and channel unspecified, with assumption of
consumer stream).

>> diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
>> index 3e419d9..24be7aa 100644
>> --- a/include/drm/i2c/tda998x.h
>> +++ b/include/drm/i2c/tda998x.h
>> @@ -1,6 +1,19 @@
>>  #ifndef __DRM_I2C_TDA998X_H__
>>  #define __DRM_I2C_TDA998X_H__
>>  
>> +#define AFMT_UNUSED	0
>> +#define AFMT_SPDIF	1
>> +#define AFMT_I2S	2
> 
> I'd prefer this to stay an enum please.
> 

Ok.

>> +struct tda998x_audio_params {
>> +	u8 config;
>> +	u8 format;
>> +	unsigned sample_width;
>> +	unsigned sample_rate;
>> +	struct hdmi_audio_infoframe cea;
> 
> With this addition, this file will need to include linux/hdmi.h.
> 

Oh yes, thanks.

>> +	u8 status[4];
> 
> A comment here about the missing byte 2 would probably be a good idea.
> 

As I said earlier, I'd rather keep this as plain channel status buffer
and just increase its size by one.

Thanks a lot for the review!

Best reagards,
Jyri
