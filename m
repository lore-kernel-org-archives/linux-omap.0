From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 09:34:50 -0700
Message-ID: <20180329163450.GQ5700@atomide.com>
References: <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com> <20180329160828.GA14007@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180329160828.GA14007@amd>
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

* Pavel Machek <pavel@ucw.cz> [180329 16:09]:
> > Then using the n_gsm ts 27.010 uart mux, I dial:
> > 
> > ./ngsm-rw 1 "AT+CFUN=1"		# connect to network
> > U0001+CFUN:OK
> > ./ngsm-rw 2 "AT+CMUT=0"		# unmute speaker over ch2, do this over qmi?
> > U0001+CMUT:OK
> > ./ngsm-rw 1 "ATD#123"		# dial number
> > U0001D:OK
> > 
> > And I do hear a voice talking over the speakerphone :) Sorry have not tested the
> > mic yet..
> 
> Hehe, ok, that's fun! I don't need +CMUT=0. It gave me error but then
> the call worked, anyway... (I'm working with ttyUSB4).

Oh interesting. So maybe Android is doing AT+CMUT=0 for some other
modems and it's not really needed? Or you have settings preserved
from warm boot from Android?

I did not have any luck with ttyUSB4 last night. Did you dial with
ATD123; or ATD123? So is the semicolon really needed?

> I don't know how to hang the call up. ATH did not work for me.

OK ATH works for me on n_gsm channel 1.

> And no, microphone does not work.

Yeah so conf calls only for now.

Tony
