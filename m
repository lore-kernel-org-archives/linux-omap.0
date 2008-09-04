From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/5] SOUND: SOC: CODECS: Add support for
	the TWL4030 audio codec
Date: Thu, 4 Sep 2008 07:32:28 -0700
Message-ID: <5e088bd90809040732x24b2123cl68fa9d2242ae2ae0@mail.gmail.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	<1220504520-6067-2-git-send-email-sakoman@gmail.com>
	<1220504520-6067-3-git-send-email-sakoman@gmail.com>
	<1220504520-6067-4-git-send-email-sakoman@gmail.com>
	<20080904132632.e64c3ce2.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080904132632.e64c3ce2.jarkko.nikula@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 4, 2008 at 3:26 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Wed,  3 Sep 2008 22:01:58 -0700
> "ext sakoman@gmail.com" <sakoman@gmail.com> wrote:

>> +static void twl4030_dump_registers(void)
>> +{
> This is not needed since there is already nice function
> for it: sound/soc/soc-core.c: codec_reg_show.

I could probably get rid of this function.  It was quite useful during
debugging and I was not aware of codec_reg_show.  IIRC, most of the
other codec drivers also have the equivalent of this function, so we
might want to clean them up too if there is a standard function to
replace them.

>> +     /* wait for offset cancellation to complete */
>> +     twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
>> REG_ANAMICL);
>> +     while ((byte & CNCL_OFFSET_START) == CNCL_OFFSET_START)
>> +             twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
>> +                                     &byte, REG_ANAMICL);
>> +
> Probably some timeout escape here.

Right you are!  This is a pet peeve of mine and I am humiliated I let
this sneak in :-)

>
>> +static void twl4030_power_down(struct snd_soc_codec *codec)
>> +{
> ...
>> +     udelay(10);
>> +}
> REVISIT comment for these kind of magic delays if doesn't work without.

It *seems* to work without them, but every historic TI driver seemed
to have them.  I figured that they might know something not reflected
in the documentation.  I will add a REVIST comment.

>> +static int twl4030_hw_params(struct snd_pcm_substream *substream,
>> +                        struct snd_pcm_hw_params *params)
>> +{
> ...
>> +     switch (params_rate(params)) {
>> +     case 44100:
>> +             mode |= APLL_RATE_44100;
>> +             break;
>> +     case 48000:
>> +             mode |= APLL_RATE_48000;
>> +             break;
>> +     default:
>> +             printk(KERN_ERR "TWL4030 hw params: unknown rate %d
>> \n",
>> +                     params_rate(params));
>> +             return -EINVAL;
>> +     }
> I checked that chip supports also other standard rates from 8 kHz,
> 11.025 kHz, etc. However I didn't find from quick look how this relates
> to interface rate. I would say that small TODO comment to whom who has
> platform to try these combinations would be nice.

It would be trivial to add support for the other data rates.  IIRC, I
just matched the data rates that were supported by mcbsp.

>> +static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>> +             int clk_id, unsigned int freq, int dir)
>> +{
> ...
>> +
>> +     infreq |= APLL_EN;
>> +     twl4030_write(codec, REG_APLL_CTL, infreq);
>> +
>> +     return 0;
>> +}
> If this actually place for set_pll callback if one wants to manage PLL
> (APLL_EN bit) dynamically?

I can add a TODO comment for this.  I'm under delivery pressure for
the next few weeks and won't get time to work on this.

Steve
