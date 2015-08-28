From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: hdmi: Reconfigure and restart
 audio when display is enabled
Date: Fri, 28 Aug 2015 14:35:52 +0300
Message-ID: <55E04798.3030905@ti.com>
References: <cover.1440594174.git.jsarha@ti.com>
 <44089dc819903c71e1d0ed0c14dd3ab060ed8c68.1440594174.git.jsarha@ti.com>
 <55E039FC.8090707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <55E039FC.8090707@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/28/15 13:37, Tomi Valkeinen wrote:
>
> On 26/08/15 16:11, Jyri Sarha wrote:
>
>> diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
>> index 7f87578..f352c4b 100644
>> --- a/drivers/video/fbdev/omap2/dss/hdmi5.c
>> +++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
>> @@ -352,6 +352,7 @@ static int read_edid(u8 *buf, int len)
>>   static int hdmi_display_enable(struct omap_dss_device *dssdev)
>>   {
>>   	struct omap_dss_device *out = &hdmi.output;
>> +	unsigned long flags;
>>   	int r = 0;
>>
>>   	DSSDBG("ENTER hdmi_display_enable\n");
>> @@ -370,7 +371,37 @@ static int hdmi_display_enable(struct omap_dss_device *dssdev)
>>   		goto err0;
>>   	}
>>
>> +	if (hdmi.audio_configured) {
>> +		spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
>> +		hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
>> +		hdmi_wp_audio_enable(&hdmi.wp, false);
>> +		if (hdmi.wp_idlemode > 0)
>> +			REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG,
>> +				    hdmi.wp_idlemode, 3, 2);
>> +		hdmi.wp_idlemode = -1;
>> +		spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
>
> Here I think the audio HW is always disabled already. It has to be,
> because the whole HDMI IP has been off. So the above should not be needed.
>
>> +
>> +		r = hdmi5_audio_config(&hdmi.core, &hdmi.wp, &hdmi.audio_config,
>> +				       hdmi.cfg.timings.pixelclock);
>> +		if (r) {
>> +			DSSERR("Error restoring audio configuration: %d", r);
>> +			hdmi.audio_abort_cb(&hdmi.pdev->dev);
>> +			hdmi.audio_configured = false;
>> +		}
>> +	}
>> +
>> +	spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
>> +	if (hdmi.audio_configured && hdmi.audio_playing) {
>> +		/* No-idle while playing audio, store the old value */
>> +		hdmi.wp_idlemode =
>> +			REG_GET(hdmi.wp.base, HDMI_WP_SYSCONFIG, 3, 2);
>> +		REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, 1, 3, 2);
>> +
>> +		hdmi_wp_audio_enable(&hdmi.wp, true);
>> +		hdmi_wp_audio_core_req_enable(&hdmi.wp, true);
>> +	}
>>   	hdmi.display_enabled = true;
>> +	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
>
> Maybe you've looked at the locking carefully, but it's not obvious to
> me. So is hdmi_audio_start and hdmi_audio_stop the only functions that
> are called from atomic context? Every other function is protected with
> the mutex?
>

The idea is for the spinlock to make audio start, audio stop, and 
updates to hdmi.display_enabled and hdmi.audio_playing variable atomic.

This is needed for the transitions from display enabled state (when 
audio start/stop commands can be written to HW) to display disabled 
state (when audio start/stop commands update only the hdmi.audio_playing 
variable) to always serialize correctly.

IOW, the idea is to make sure the hdmi.audio_playing variable is always 
in sync with what is in the HW when hdmi.display_enabled == true.

For example: when display is turned back on we take the spinlock and we 
can be sure that the audio start/stop status won't change while we 
update the HW according to current state and set hdmi.display_enabled to 
true. After releasing the lock hdmi.display_enabled is true and all 
audio_start and audio_stop commands write their stuff directly to HW.

In theory, just making hdmi.display_enabled and hdmi.audio_playing 
atomic-variables and touching them always in correct oreder should be 
enough, but explaining the mechanism would then be even trickier.

Cheers,
Jyri
