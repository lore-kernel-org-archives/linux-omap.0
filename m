From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 audio: any ideas how to get headset speaker to work?
Date: Mon, 16 Feb 2015 10:57:48 +0100
Message-ID: <20150216095748.GA25918@amd>
References: <20150215102152.GA23736@amd>
 <CAK7bGn+NH9BOB25+dhNZXFxY_fD8TeoWvuSpTD-4cg-zU5dOmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7bGn+NH9BOB25+dhNZXFxY_fD8TeoWvuSpTD-4cg-zU5dOmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrik Bachan aka DiGGiT <patrikbachan@gmail.com>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

Ahoj!

> > By default, output goes to loudspeaker (top right relative to
> > keyboard). Any ideas how to switch it to the speaker on the left or
> > wired headset? Because I suspect that echo cancelation is not going to
> > be simple...
> >                                                                         Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> Hi,
> in case of direct alsa output (not PA), setup is pretty complex.
> Headphones referenced as line. All audio outputs are differential.
> Here are controls that affects volumes...

Aha, thanks for nice explanation. Now it starts to make sense... I got
headset connected to 3.5" jack to work.

Now, I guess I'd like the internal speaker on the left to work,
too... Aha, so n900 has two stereo "loud" speakers on the keyboard
part, plus extra speaker on the left display part for communication?

I got the two stereo ones to work now.

Any idea what is the last speaker on display is called? HPCOM? Mono?

> global:
>  PCM (volume)
>  left/right DAC mux (below)
>       -- DAC_L1/R1 passes sound to loudspeakers, line, (maybe others)
>       -- DAC_L2/R2 passes sound to loudspeakers, NOT line, (maybe others)
>       -- DAC_L3/R3 passes sound to NOT loudspeakers, line, (maybe others)
>       if DAC_L1/R1 is chosen, you can hear lower volume on both
> outputs in compare to dedicated outputs (DAC_L2/R2, DAC_L3/R3),
> probabbly due to higher load of ADC
> 
> 
> loudspeakers:
>  Speaker function (on)
>  HP (unmute)
>  HP DAC (volume)
>  left HP Mixer DACL1 (below)
>  right HP Mixer DACR1 (below)
>    --unmute theese two,  this will pass left channel sound to left
> channel output and vice versa
>  left HP Mixer DACR1 (below)
>  right HP Mixer DACL1 (below)
>   --mute these two, this controls channel crosstalk ( amount of left
> channel sound going to right channel output and vice versa)
> 
> line:
>  line (unmute)
>  line DAC (volume)
>  jack function (headphone)
>  TPA6130A2 Headphone (volume)
>  left Line Mixer DACL1 (below)
>  right Line Mixer DACR1 (below)
>    --unmute theese two,  this will pass left channel sound to left
> channel output and vice versa
>  left Line Mixer DACR1 (below)
>  right Line Mixer DACL1 (below)
>   --mute these two, this controls channel crosstalk ( amount of left
> channel sound going to right channel output and vice versa)

Thanks a lot!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
