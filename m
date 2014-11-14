From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v7.1 11/19] OMAPDSS: hdmi: Make
 hdmi_mode_has_audio() more user friedly
Date: Fri, 14 Nov 2014 17:05:20 +0200
Message-ID: <54661A30.3010708@ti.com>
References: <cover.1415803064.git.jsarha@ti.com>
 <8047b50c76efecd72e7219f7871c59cc4a8ee5f5.1415803065.git.jsarha@ti.com>
 <5466139E.5040308@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5466139E.5040308@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/14/2014 04:37 PM, Vladimir Zapolskiy wrote:
> Hi Jyri,
>
> On 12.11.2014 16:41, Jyri Sarha wrote:
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>   drivers/video/fbdev/omap2/dss/hdmi.h |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
>> index a6e08ff..6d129f2 100644
>> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
>> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
>> @@ -345,9 +345,9 @@ void hdmi_wp_audio_config_format(struct hdmi_wp_data *wp,
>>   		struct hdmi_audio_format *aud_fmt);
>>   void hdmi_wp_audio_config_dma(struct hdmi_wp_data *wp,
>>   		struct hdmi_audio_dma *aud_dma);
>> -static inline bool hdmi_mode_has_audio(int mode)
>> +static inline bool hdmi_mode_has_audio(struct hdmi_config *cfg)
>>   {
>> -	return mode == HDMI_HDMI ? true : false;
>> +	return cfg->hdmi_dvi_mode == HDMI_HDMI ? true : false;
>>   }
>>
>>   /* HDMI DRV data */
>>
>
> would it be possible for you to rearrange the changes preserving the
> following sequence?
>
> 1) 13/19
> 2) 15/19
> 3) 11/19
> 4) 14/19
> 5) 16/19
>

Sure, I can do that. Everything should be fine in that order too.

> Otherwise I'm worried that someone's git rebase may fail.
>

But do not follow why. Did you notice that 10/19 removes the config 
options that enable the pieces of code that are deleted in 13/19 and 
15/19. IOW, the code that uses hdmi_mode_has_audio() (and would become 
broken by 11/19) is already disabled by 10/19. Git-wise I see no problem 
either.

I'll rearrange the patches if you still insist there is a problem with 
current order, but I would like to understand why.

Best regards,
Jyri
