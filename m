From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Can a phone hook switch follow alsa jack model?
Date: Tue, 23 Jun 2009 23:22:56 +0100
Message-ID: <20090623222255.GA5617@sirena.org.uk>
References: <4A40D896.8010208@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4A40D896.8010208@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 23, 2009 at 03:28:54PM +0200, Janusz Krzysztofik wrote:

> After my initial attempt to add support for the switch using gpio-keys 
> driver, I am no longer sure if it is a good idea to follow the keyboard 
> model, that the driver has been designed after, for driving a switch 
> that has nothing to do with keyboards and may required a different approach.

That approach was quite common in the past.

> However, I am not sure if the switch in question matches the alsa jack 
> model closely enough. I see the switch usage not as simple as turning 
> handset microphone/speaker on or off. It can be used for other purposes 
> as well, like accepting a phone call or actually dialing a number that 
> has been just typed in. Furthermore, it can be used to turn off a 
> speakerphone function, while, in turn, the related handset 
> microphone/speaker pair can be turned off not only with this switch, but 
> with a handsfree button as well, for example.

That can all be accomodated within the ASoC jack framework (I'm assuming
you'll be doing an ASoC rather than generic ALSA driver).  You get the
input device just the same as you get with gpio-keys so you can do stuff
in user space, the main difference is that you can also arrange for some
of the power management within ASoC to be hooked up with the jack
automatically as well.

With what you're describing above I'd tie the mic and speaker in the
headset to DAPM automatically.

> All that extra functionality looks like belonging to userspace rather 
> then kernel, not like other alsa jack implementations that seem to do 
> all the job of switching media paths inside the kernel. That is why I am 
> not sure if the jack model is suitable for the purpose.

The switching in kernel for ASoC should generally be confined to marking
outputs as powered or unpowered - things like marking a headphone jack
as disabled when there's nothing plugged in to it that can be done
unconditionally.  Everything else should get punted to user space.
