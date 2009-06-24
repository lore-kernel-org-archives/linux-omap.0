From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Can a phone hook switch follow alsa jack model?
Date: Wed, 24 Jun 2009 15:28:11 +0200
Message-ID: <4A4229EB.2090606@tis.icnet.pl>
References: <4A40D896.8010208@tis.icnet.pl>
	<20090623222255.GA5617@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090623222255.GA5617@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,

Mark Brown wrote:
> On Tue, Jun 23, 2009 at 03:28:54PM +0200, Janusz Krzysztofik wrote:
>> However, I am not sure if the switch in question matches the alsa jack 
>> model closely enough. I see the switch usage not as simple as turning 
>> handset microphone/speaker on or off. It can be used for other purposes 
>> as well, like accepting a phone call or actually dialing a number that 
>> has been just typed in. Furthermore, it can be used to turn off a 
>> speakerphone function, while, in turn, the related handset 
>> microphone/speaker pair can be turned off not only with this switch, but 
>> with a handsfree button as well, for example.
> 
> That can all be accomodated within the ASoC jack framework (I'm assuming
> you'll be doing an ASoC rather than generic ALSA driver).

Right, thanks for pointing out the difference.

>  You get the
> input device just the same as you get with gpio-keys so you can do stuff
> in user space,

Yes, that was quite simple :). For now, I used SND_JACK_HEADSET report 
type. Don't you think that a new type like SND_JACK_PHONE_HOOK or 
SND_JACK_PHONE_HANDSET should be defined for the purpose? Even if 
HEADSET may not be very different from HANDSET, corresponding 
SW_HEADPHONE_INSERT and SW_MICROPHONE_INSERT event names seem have very 
little to do with picking up a phone.

> the main difference is that you can also arrange for some
> of the power management within ASoC to be hooked up with the jack
> automatically as well.
> 
> With what you're describing above I'd tie the mic and speaker in the
> headset to DAPM automatically.

OK, I'll try to follow your advice when I'm ready with a method of 
switching my microphones/speakers.

>> All that extra functionality looks like belonging to userspace rather 
>> then kernel, not like other alsa jack implementations that seem to do 
>> all the job of switching media paths inside the kernel. That is why I am 
>> not sure if the jack model is suitable for the purpose.
> 
> The switching in kernel for ASoC should generally be confined to marking
> outputs as powered or unpowered - things like marking a headphone jack
> as disabled when there's nothing plugged in to it that can be done
> unconditionally.  Everything else should get punted to user space.

So, if I want to follow the ASoC jack model, my in-kernel hook switch 
handler should only power on/off the handset, not touching the 
speakerphone at all. The latter should be controlled from userspace. 
Please correct me if I am missing something.

Thanks,
Janusz
