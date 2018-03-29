From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 06:59:04 -0700
Message-ID: <20180329135904.GN5700@atomide.com>
References: <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329133613.khldv72w3zj63vsk@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180329 13:37]:
> Hi,
> 
> On Wed, Mar 28, 2018 at 06:45:07PM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180328 14:03]:
> > > Hi,
> > > 
> > > On Wed, Mar 28, 2018 at 10:29:10AM +0800, Mark Brown wrote:
> > > > On Wed, Mar 28, 2018 at 12:22:37AM +0200, Sebastian Reichel wrote:
> > > > > On Tue, Mar 27, 2018 at 08:14:41PM +0800, Mark Brown wrote:
> > > > 
> > > > > > No, this is exactly the sort of use case with multiple DAIs that the
> > > > > > graph card is intended to enable over the old simple-card.
> > > > 
> > > > > +----------+         +-------------+
> > > > > | OMAP4    |         | CPCAP       |
> > > > > |          |         |             |
> > > > > | [McBSP2] | <-----> | [HiFi DAI]  |
> > > > > |          |         |             |
> > > > > | [McBSP3] | <--+--> | [Voice DAI] |
> > > > > |          |    |    |             |
> > > > > +----------+    |    +-------------+
> > > > >                 |
> > > > > +----------+    |    +-------------+
> > > > > | MDM6600  |    |    | WL1285      |
> > > > > |          |    |    |             |
> > > > > |    [DAI] | <--+--> | [DAI]       |
> > > > > |          |         |             |
> > > > > +----------+         +-------------+
> > > > 
> > > > > Legend:
> > > > >     OMAP4   = SoC running Linux
> > > > >     CPCAP   = Audio codec
> > > > >     MDM6600 = Baseband
> > > > >     WL1285  = Bluetooth
> > > > 
> > > > > Re-reading the audio-graph-card binding document I still don't see
> > > > > how the network (OMAP.McBSP3, CPCAP.Voice, MDM6600, WL1285) is
> > > > > supposed to look like. It seems to expect point-to-point DAI
> > > > > connections.
> > > > 
> > > > Ugh, a TDM mux?
> > > 
> > > Yes, at least that's how I understood Motorola's code.
> > 
> > Hmm is there some active component doing the muxing then?
> > Maybe the "AT+CMUT=0" part below?
> 
> I don't think, that there is a special hardware mux. I think each
> device is configured to use a proper timeslot and/or is being used
> exclusively.

OK. I wonder what "AT+CMUT=0" on mdm6600 then does? If a voice
call is requested and mdm6600 only has one i2s output it seems
kind of unnecesary :)

> > > > That's really unusual and not particularly supported yet, you'd
> > > > need to extend the graph card to do it.  It's where things should
> > > > end up for a generic card though.
> > > 
> > > Motorola's driver provided the following modes:
> > > 
> > > OMAP4 <-> CPCAP      (voice recording)
> > > MDM6600 <-> CPCAP    (voice call, CPU not involved)
> > > OMAP4 <-> WL1285     (bluetooth HFP/HSP)
> > > MDM6600 <-> WL1285   (bluetooth voice call)
> > > 
> > > In case of the last two variants, the bus clock is provided by
> > > CPCAP, so it needs to be enabled for any audio stream. I suppose
> > > the codec <-> codec as part of TDM is out of scope for the graph
> > > card and we need a Droid 4 specific card driver?
> > 
> > Hmm well I got audio call hacked to work as a proof of concept hack,
> > see below. Maybe it can be used to verify some of the assumptions
> > above.
> 
> Your proof of concept verifies the assumption, that the modem is
> connected to the CPCAP voice DAI. This patchset is a proof, that the
> voice DAI is connected to OMAP. So we can tell for sure, that this
> is not a common direct DAI-to-DAI connection.

OK

> > @@ -510,17 +510,17 @@
> >  07f4: 0000
> >  07f8: 0000
> >  07fc: 0000
> > -0800: 0065
> > -0804: 0000
> > -0808: 0040
> > +0800: 0025     # CPCAP_REG_VAUDIOC     VAUDIO Control
> 
> enable vaudio (obviously required :))
> 
> > +0804: 60cf     # CPCAP_REG_CC          Codec Control, moto cpcap.c:1337 sets 0x0093?
> 
> 0x6000 => clkfreq=19200000
> 
> The following bits are automatically set via DAPM by cpcap codec,
> once it is used:
> 
> 0x00c0 => "ADC Left" + "DAC Voice"
> 0x000f => "Highpass Filter TX" + "Highpass Filter RX"
> 
> > +0808: ae0a     # CPCAP_REG_CDI         Codec Digital Interface
> 
> 0xa000 => enable PLL & use clock 1
> 
> This should be used by default for VOICE DAI.
> 
> 0x0e00 => "Voice DAI Clock"=1 (handled by DAPM) , mode=I2S
> 0x000a => CPCAP_BIT_CLK_INV | CPCAP_BIT_MIC1_RX_TIMESLOT0
> 
> >  080c: 0000
> >  0810: 0004
> > -0814: 0804
> > -0818: 079c
> > -081c: 0000
> > -0820: 0924
> > -0824: 0000
> > -0828: 0000
> > +0814: 0cc0     # CPCAP_REG_TXI         TX Inputs, moto cpcap.c:1340 sets 0x0CC6?
> > +0818: 0610     # CPCAP_REG_TXMP        TX MIC PGA's, moto cpcap.c:1343 sets 0x0273?
> > +081c: 0006     # CPCAP_REG_RXOA        RX Output Amplifiers
> > +0820: 0b2c     # CPCAP_REG_RXVC        RX Volume Control
> > +0824: 0606     # CPCAP_REG_RXCOA       RX Codec to Output Amps
> > +0828: 0600     # CPCAP_REG_RXSDOA      RX Stereo DAC to Output Amps
> 
> This configures the loudspeaker, mics and volume and enables the
> required clocks/DACs/... This is already covered by the cpcap codec
> driver. You just need to configure everything correctly in
> alsamixer.
> 
> >  082c: 0400
> >  0830: 0000
> >  0834: 0030
> > 
> > I wonder if mdm6600 is the i2s master during the voice call?
> 
> I think cpcap is always the clock and frame master, but I think
> mdm6600 is the remote side and OMAP is not involved at all.

OK. So could it be just an alsamixer on/off toggle then for
"Modem" or something similar?

> > Then using the n_gsm ts 27.010 uart mux, I dial:
> > 
> > ./ngsm-rw 1 "AT+CFUN=1"		# connect to network
> > U0001+CFUN:OK
> > ./ngsm-rw 2 "AT+CMUT=0"		# unmute speaker over ch2, do this over qmi?
> > U0001+CMUT:OK
> > ./ngsm-rw 1 "ATD#123"		# dial number
> > U0001D:OK

There's a typo above, it should be just ATD123 where 123 is the
number.

I was just doing few test calls to robots. Payback time for all
the robocalls, you know! :)

> > And I do hear a voice talking over the speakerphone :) Sorry have not tested the
> > mic yet..

And calling a person I can hear the other end but the mic is
not working. So maybe I need to tweak the alsamixer settings
too for mic?

Regards,

Tony
