From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 14:58:40 -0700
Message-ID: <20180329215840.GT5700@atomide.com>
References: <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com> <20180329160828.GA14007@amd>
 <20180329163450.GQ5700@atomide.com> <20180329180541.GA26545@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180329180541.GA26545@amd>
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

* Pavel Machek <pavel@ucw.cz> [180329 18:07]:
> On Thu 2018-03-29 09:34:50, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180329 16:09]:
> > > > Then using the n_gsm ts 27.010 uart mux, I dial:
> > > > 
> > > > ./ngsm-rw 1 "AT+CFUN=1"		# connect to network
> > > > U0001+CFUN:OK
> > > > ./ngsm-rw 2 "AT+CMUT=0"		# unmute speaker over ch2, do this over qmi?
> > > > U0001+CMUT:OK
> > > > ./ngsm-rw 1 "ATD#123"		# dial number
> > > > U0001D:OK
> > > > 
> > > > And I do hear a voice talking over the speakerphone :) Sorry have not tested the
> > > > mic yet..
> > > 
> > > Hehe, ok, that's fun! I don't need +CMUT=0. It gave me error but then
> > > the call worked, anyway... (I'm working with ttyUSB4).
> > 
> > Oh interesting. So maybe Android is doing AT+CMUT=0 for some other
> > modems and it's not really needed? Or you have settings preserved
> > from warm boot from Android?
> 
> No idea. But I booted from recovery, and I had to power up modem using
> +CFUN...
> 
> > I did not have any luck with ttyUSB4 last night. Did you dial with
> > ATD123; or ATD123? So is the semicolon really needed?
> >
> 
> AT+CFUN=1
> OK
> ATD800123456
> NO CARRIER
> ATD800123456;
> OK
> 
> I seem to need semicolon. And yes, I tried again after the call. Still
> says no carrier.

OK thanks for confirming that.

> Hmm. And when calling test number, the modem failed:
> >
> [  438.236755] Somebody do a proper driver please cpcap_soc_work
> [  495.496032] phy-mapphone-mdm6600 usb-phy@1: modem status: 0 off
> [  499.406005] phy-mapphone-mdm6600 usb-phy@1: modem status: 0 off
> [  499.407318] usb 2-1: USB disconnect, device number 2
> [  499.424926] qcserial ttyUSB0: Qualcomm USB modem converter now
> disconnected from ttyUSB0
> [  499.434112] qcserial 2-1:1.0: device disconnected
> [  499.443389] qcserial ttyUSB1: Qualcomm USB modem converter now
> disconnected from ttyUSB1
> [  499.451904] qcserial 2-1:1.1: device disconnected
> [  499.460968] qcserial ttyUSB2: Qualcomm USB modem converter now
> disconnected from ttyUSB2
> [  499.469512] qcserial 2-1:1.2: device disconnected
> [  499.478057] qcserial ttyUSB3: Qualcomm USB modem converter now
> disconnected from ttyUSB3
> [  499.486572] qcserial 2-1:1.3: device disconnected
> [  499.504760] qcserial ttyUSB4: Qualcomm USB modem converter now
> disconnected from ttyUSB4
> [  499.513244] qcserial 2-1:1.4: device disconnected
> [  499.519104] qmi_wwan 2-1:1.5 wwan0: unregister 'qmi_wwan'
> usb-4a064800.ohci-1, WWAN/QMI device
> [  499.611511] qmi_wwan 2-1:1.6 wwan1: unregister 'qmi_wwan'
> usb-4a064800.ohci-1, WWAN/QMI device
> [  499.676086] Somebody do a proper driver please cpcap_soc_work
> [  499.688323] qmi_wwan 2-1:1.7 wwan2: unregister 'qmi_wwan'
> usb-4a064800.ohci-1, WWAN/QMI device
> [  499.768859] qmi_wwan 2-1:1.8 wwan3: unregister 'qmi_wwan'
> usb-4a064800.ohci-1, WWAN/QMI device
> 
> That one will be fun to debug, I'm afraid. (Or does the message at
> 495.496032 mean that we turned it off?)

Looks like mdm6600 either entered low-power mode, or hung?
If it hung, it's internal watchdog might bring it back after
a while.

If it entered low-power mode, in theory we should see the state
change interrupt that's handled by phy-mapphone-mdm6600.c.
I never managed to do that so far so maybe you figured it out
with some command.

Regards,

Tony
