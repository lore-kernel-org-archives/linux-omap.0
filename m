From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Mon, 17 Jul 2017 22:48:33 -0700
Message-ID: <20170718054833.GL10026@atomide.com>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170717092904.GG10026@atomide.com>
 <20170717101258.llyly7kwfnwtoftr@earth>
 <20170717101709.GI10026@atomide.com>
 <20170717141347.t2642xbkol3g36rv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717141347.t2642xbkol3g36rv@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170717 07:14]:
> Hi,
> 
> On Mon, Jul 17, 2017 at 03:17:10AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170717 03:13]:
> > > On Mon, Jul 17, 2017 at 02:29:04AM -0700, Tony Lindgren wrote:
> > > > * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170712 08:19]:
> > > > >  * Switch from simple-audio-card to audio-graph-card
> > > > 
> > > > Gave this a quick try against v4.13-rc1 with SND_AUDIO_GRAPH_CARD
> > > > enabled as a loadable module. However loading it oopses for me,
> > > > see below. Maybe some dependencies are missing?
> > > 
> > > It works for me on top of v4.13-rc1 (my kernel is monolithic).
> > > Looking at the stacktrace it seems to be a bug in audio graph
> > > card and not in the codec driver.
> > 
> > OK I do also have:
> > 
> > CONFIG_DEBUG_LOCKDEP=y
> > CONFIG_DEBUG_ATOMIC_SLEEP=y
> 
> I added those and I do not get a stacktrace for anything sound
> related and audio works. I noticed one issue in dapm routing,
> that I accidently added. That will be fixed in PATCHv3, but its
> in untestable path anyways (EXT capture, probably FM radio is
> connected to EXT).

Hmm maybe that was not with DEBUG_ATOMIC_SLEEP then? I also
verified it does not happen unless your dts patch
"ARM: dts: omap4-droid4: add soundcard" is applied.

I doubt that having it as loadable module makes any difference
here as it's the might_sleep() in __mutex_lock_common() producing
the BUG.

Regards,

Tony
