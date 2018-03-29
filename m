From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 09:06:11 -0700
Message-ID: <20180329160611.GP5700@atomide.com>
References: <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329154600.qhels5fqzzg364gj@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180329 15:47]:
> Hi,
> 
> On Thu, Mar 29, 2018 at 06:59:04AM -0700, Tony Lindgren wrote:
> > > I think cpcap is always the clock and frame master, but I think
> > > mdm6600 is the remote side and OMAP is not involved at all.
> > 
> > OK. So could it be just an alsamixer on/off toggle then for
> > "Modem" or something similar?
> 
> I think so. We might want to have an "Mode" enum instead, though.
> That can be extended, once we unlock the other modes (bluetooth,
> bluetooth call).

OK. Seems in addition to the "Mode" enum, we also need
some other switch for modem on and off toggle?

I guess most people want to save the preferred "Mode" enum,
then for the duration of the call enable the selected mode.

And I guess the mute is already there for the mic with 'm'
in alsamixer for conf calls :)

> > > > Then using the n_gsm ts 27.010 uart mux, I dial:
> > > > 
> > > > ./ngsm-rw 1 "AT+CFUN=1"		# connect to network
> > > > U0001+CFUN:OK
> > > > ./ngsm-rw 2 "AT+CMUT=0"		# unmute speaker over ch2, do this over qmi?
> > > > U0001+CMUT:OK
> > > > ./ngsm-rw 1 "ATD#123"		# dial number
> > > > U0001D:OK
> > 
> > There's a typo above, it should be just ATD123 where 123 is the
> > number.
> > 
> > I was just doing few test calls to robots. Payback time for all
> > the robocalls, you know! :)
> >
> > > > And I do hear a voice talking over the speakerphone :) Sorry have not tested the
> > > > mic yet..
> > 
> > And calling a person I can hear the other end but the mic is
> > not working. So maybe I need to tweak the alsamixer settings
> > too for mic?
> 
> Your override kills most settings from alsamixer. You can try to
> just override CPCAP_REG_VAUDIOC, CPCAP_REG_CC and CPCAP_REG_CDI
> and setup everything else with alsamixer.

OK I'll try to narrow it down and play with the mic settings
tonight or over the weekend.

Regards,

Tony
