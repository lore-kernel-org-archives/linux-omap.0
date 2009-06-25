From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] Can a phone hook switch follow alsa jack model?
Date: Thu, 25 Jun 2009 14:48:38 +0200
Message-ID: <4A437226.4090202@tis.icnet.pl>
References: <4A40D896.8010208@tis.icnet.pl> <20090623222255.GA5617@sirena.org.uk> <4A4229EB.2090606@tis.icnet.pl> <20090625110508.GF17812@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20090625110508.GF17812@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jonathan McDowell <noodles@earth.li>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2009-06-25 13:05, Mark Brown wrote:
> On Wed, Jun 24, 2009 at 03:28:11PM +0200, Janusz Krzysztofik wrote:
> 
>> type. Don't you think that a new type like SND_JACK_PHONE_HOOK or 
>> SND_JACK_PHONE_HANDSET should be defined for the purpose? Even if 
>> HEADSET may not be very different from HANDSET, corresponding 
>> SW_HEADPHONE_INSERT and SW_MICROPHONE_INSERT event names seem have very 
>> little to do with picking up a phone.
> 
> Possibly, TBH I had thought I'd seen something for off-hook when I
> looked at this originally but I can't seem to spot it now.

As I am not native English, please somebody help me to choose best 
names, both SW_... event name and SND_JACK_... jack type.

During my previous, gpio-keys based attempt, I submitted a patch that 
added new SW_HANDSET_PICK_UP event definition to include/linux/input.h. 
Even if not accepted because of no acompanying code that would make use 
of it, there were no other comments, especially on the name I have 
choosen. However, there were another name proposed by ams-delta board 
maintainer, Jonathan McDowell - SW_PHONE_HOOK. Even if my wording may 
better match those already existing ..._INSERT names, I am not sure 
which one should I use.

Please also note that SND_JACK_HEADSET, that I temporarily use for now, 
is an alias for SND_JACK_HEADPHONE | SND_JACK_MICROPHONE. Those two can 
be seen as matching what a handset actually is. On headset jack 
insert/remove, two distinct reports/events are generated, one for a 
microphone, and one for a headphone. Should this schema be used with a 
handset? Even if it were possible to turn any of handset microphone or 
headphone individually, would it make any sense?

Sorry for bothering you with all this stuff, but I'd like the changes to 
existing code I am going to propose, if any, be as much reusable as 
possible.

>> So, if I want to follow the ASoC jack model, my in-kernel hook switch 
>> handler should only power on/off the handset, not touching the 
>> speakerphone at all. The latter should be controlled from userspace. 
>> Please correct me if I am missing something.
> 
> That's my initial guess - I've not looked at your particular hardware
> so it may not end up being the best way of dealing with your system but
> from what you said it was the approach that sprang to mind.

Mark,
Thanks for now, all that seems clear enough for me.
Janusz

