From: Tony Lindgren <tony@atomide.com>
Subject: Re: call/normal switch was Re: omap4-droid4: voice
	call support was
Date: Sat, 31 Mar 2018 12:46:38 -0700
Message-ID: <20180331194638.GY5700@atomide.com>
References: <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com> <20180331145531.GA10404@amd>
 <20180331181935.GX5700@atomide.com> <20180331191939.GA8999@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180331191939.GA8999@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180331 19:21]:
> On Sat 2018-03-31 11:19:35, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180331 14:56]:
> > > Hi!
> > > 
> > > > Hmm well I got audio call hacked to work as a proof of concept hack,
> > > > see below. Maybe it can be used to verify some of the assumptions
> > > > above.
> > > > 
> > > > Then.. To split the work a bit, can you guys maybe try to decode
> > > > the cpcap register values and try to do a proper ASoC driver patch?
> > > 
> > > This is not proper patch yet, but it should be a step in that
> > > direction...
> > 
> > Cool :) Microphone still does not work for me.. I tried tweaking
> > the alsamixer settings but no mic. This is with cold boot with
> > droid4-kexecboot if that might make a difference, we may have
> > some register uninitialized somewhere. Any ideas?
> 
> Ok, I was focusing on the speaker side.
> 
> alsamixer, tab to go to capture settings, set it to 37 37 Mic2 Mic1
> should work, according to my notes, but not recently tested and not
> tested against real human.

In alsamixer after setting the second "Speaker" to "Voice" and "Mode"
to "Call" and "Left" to "Mic 2" and "Right" to "Mic 1" and doing a
test call the mic does not work, speaker works though.

After the call in alsamixer, setting the second "Speaker" to "HiFi",
and "Mode" to "Normal" mode, I can record a wav file and play it back
just fine. But this only works for me after reloading snd-soc-cpcap.ko
after the voice call.

> I'll attempt to test it, but something in my userland shuts down
> system just after boot 60% of time, which is rather annoying.

Hmm battery voltage too low? We have cpcap_battery_irq_thread()
call orderly_poweroff() on lowbpl interrupt.

> > FYI, I got one of the remaining n_gsm issues tracked down yesterday,
> > at least one more bug to go. Things only work with n_gsm debug
> > enabled right now for some reason..
> 
> I don't know why I need n_gsm, but I have my fingers crossed. :-).

More features it seems :) But sounds like you're all set for now
with USB access.

Regards,

Tony
