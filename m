From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Re: [PATCHv4 7/7] ASoC: TWL6030: Detect power-up
 sequence completion
Date: Mon, 1 Mar 2010 19:52:37 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65F3EAC5@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65E7E58C@dlee06.ent.ti.com>
	<20100301121336.GA26740@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100301121336.GA26740@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Monday, March 01, 2010 6:14 AM  Mark Brown wrote: 

> On Fri, Feb 26, 2010 at 06:22:34PM -0600, Olaya, Margarita wrote:
> 
>> Do you mean something like this?
>> time_left = wait_for_completion_timeout(&priv->ready,
>>                                         msecs_to_jiffies(48));
>> 	if(!time_left) { twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
>>                                         &intid, TWL6040_REG_INTID);
>>       if (!(intid & TWL6040_READYINT))
>> 		goto error;
>> }
>> 
>> 	return 0;
>> 
>> error:
>> 	dev_err(codec->dev, "timeout waiting for READYINT\n");
>> 	return -ETIMEDOUT;
> 
> Yes, or wrapped in a for loop with shorter timeouts on the
> individual waits. 
> 
>> but in this case will it not take unnecessarily 48ms when the
>> interruption line is not valid?
> 
> You're always going to get some additional delay when polling
> unless you
> busy wait for completion, which obviously has its own problems.

Ok, thanks for the comment I'll re-write the loop for next version of
patches
