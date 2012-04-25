From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 10/10] OMAPDSS: HDMI: Implement DSS driver interface for
 audio
Date: Tue, 24 Apr 2012 23:48:14 -0500
Message-ID: <4F97820E.2020006@ti.com>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>  <1332974305-4578-11-git-send-email-ricardo.neri@ti.com> <1335186116.1535.23.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192Ab2DYEsV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 00:48:21 -0400
In-Reply-To: <1335186116.1535.23.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org

On 04/23/2012 08:01 AM, Tomi Valkeinen wrote:
> On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
>> Implement the DSS device driver audio support interface in the HDMI
>> panel driver and generic driver. The implementation relies on the
>> IP-specific functions that are defined at DSS probe time.
>>
>> A HW-safe spinlock is used to protect the audio functions. This is because
>
> What is a "HW-safe spinlock"?
Sorry, I meant a spinlock that disables the HW irqs when held:hardirq-safe.

>
>> the audio functions may be called while holding a lock; in such case,
>> the panel's driver mutex is not suitable. Functions should be used
>> to set registers and should not wait for any other event.
>
> Are you sure this is the only option? What lock is being held?
For instance, ALSA calls the start audio function while holding a 
hardirq-safe readlock. Hence, when reaching the HDMI panel start 
function, a lock is held and irqs are disabled. Using a mutex, that 
might sleep, is not correct; nor it is using an hardirq-unsafe spinlock. 
Otherwise, deadlocks and/or inverse lock ordering may arise. This 
situation was signaled by lockdep.

IMHO, as the DSS device driver does not know who is going to use it (at 
least the audio part), it should not assume that no locks are held when 
its functions are called.

> While a spinlock may be ok for now, quite often enabling/disabling things do not
> happen immediately,and it's much easier to do the wait synchronously.
I don't understand this comment. To me, holding a lock until the 
enabling function returns is synchronous. Would you please clarify?

>
>> Signed-off-by: Ricardo Neri<ricardo.neri@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss.h        |    7 +++
>>   drivers/video/omap2/dss/hdmi.c       |   33 +++++++++++++++
>>   drivers/video/omap2/dss/hdmi_panel.c |   76 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 116 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
>> index 32ff69f..fca4490 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -520,6 +520,13 @@ int omapdss_hdmi_read_edid(u8 *buf, int len);
>>   bool omapdss_hdmi_detect(void);
>>   int hdmi_panel_init(void);
>>   void hdmi_panel_exit(void);
>> +#ifdef CONFIG_OMAP4_DSS_HDMI_AUDIO
>> +int hdmi_audio_enable(bool enable);
>> +int hdmi_audio_start(bool start);
>> +bool hdmi_mode_has_audio(void);
>> +int hdmi_audio_config(struct snd_aes_iec958 *iec,
>> +		struct snd_cea_861_aud_if *aud_if);
>> +#endif
>>
>>   /* RFBI */
>>   #ifdef CONFIG_OMAP2_DSS_RFBI
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
>> index bd44891..880509d 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -698,6 +698,39 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
>>
>>   	return 0;
>>   }
>> +
>> +int hdmi_audio_enable(bool enable)
>> +{
>> +	DSSDBG("audio_enable\n");
>> +
>> +	hdmi.ip_data.ops->audio_enable(&hdmi.ip_data, enable);
>
> Shouldn't this, and the others below, return the value from the called
> function, instead of always returning 0?

Yes, at the time of writing this patch, the HDMI ops that you refer to 
returned void. In v2, I will submit a patch for the HDMI ops to return a 
result value which will also be returned by the DSS audio interface 
functions just as you point out.
>
>> +
>> +	return 0;
>> +}
>> +
>> +int hdmi_audio_start(bool start)
>> +{
>> +	DSSDBG("audio_enable\n");
>> +
>> +	hdmi.ip_data.ops->audio_start(&hdmi.ip_data, start);
>> +
>> +	return 0;
>> +}
>> +
>> +bool hdmi_mode_has_audio(void)
>> +{
>> +	if (hdmi.ip_data.cfg.cm.mode == HDMI_HDMI)
>> +		return true;
>> +	else
>> +		return false;
>> +}
>> +
>> +int hdmi_audio_config(struct snd_aes_iec958 *iec,
>> +		struct snd_cea_861_aud_if *aud_if)
>> +{
>> +	return hdmi.ip_data.ops->audio_config(&hdmi.ip_data, iec, aud_if);
>> +}
>> +
>>   #endif
>>
>>   /* HDMI HW IP initialisation */
>> diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
>> index 533d5dc..dac1ac2 100644
>> --- a/drivers/video/omap2/dss/hdmi_panel.c
>> +++ b/drivers/video/omap2/dss/hdmi_panel.c
>> @@ -31,6 +31,10 @@
>>
>>   static struct {
>>   	struct mutex hdmi_lock;
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>> +	/* protects calls to HDMI driver audio functionality */
>> +	spinlock_t hdmi_sp_lock;
>
> What does "sp" stand for? Spinlock? Perhaps a better name would be
> "audio_lock", if it's audio specific. And probably no reason to prefix
> it with "hdmi", as it's inside "hdmi" struct already.
Yes, sp stands for spinlock. I prefixed the name with "hdmi" to align 
with the naming of the HDMI mutex. Maybe audio_lock is a better name. I 
could also submit a patch to remove the "hdmi" prefix in the mutex name.

BR,

Ricardo
>
>   Tomi

