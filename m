From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 08:44:46 -0700
Message-ID: <20180330154445.GV5700@atomide.com>
References: <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd> <20180329164113.GR5700@atomide.com>
 <20180329184007.GA27688@amd> <20180329215612.GS5700@atomide.com>
 <20180330103744.GA17404@amd>
 <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
 <20180330152227.GU5700@atomide.com>
 <CAOf5uwnF8qTqX9O6s226=Nd4FbGjGev4LDonovgoXtoEH9QdVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwnF8qTqX9O6s226=Nd4FbGjGev4LDonovgoXtoEH9QdVA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Dan Williams <dcbw@redhat.com>, Merlijn Wajer <merlijn@wizzup.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, kernel@collabora.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Michael Nazzareno Trimarchi <michael@amarulasolutions.com> [180330 15:27]:
> Hi
> 
> On Fri., 30 Mar. 2018, 11:22 pm Tony Lindgren, <tony@atomide.com> wrote:
> 
> > * Merlijn Wajer <merlijn@wizzup.org> [180330 13:09]:
> > > On 30/03/18 12:37, Pavel Machek wrote:
> > > > On Thu 2018-03-29 14:56:13, Tony Lindgren wrote:
> > > >> * Pavel Machek <pavel@ucw.cz> [180329 18:41]:
> > > >>> Thanks. I got call working including outgoing audio: in capture
> > > >>> settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
> > > >>> the other phone muted, so I don't yet know if such call would be of
> > > >>> usable quality.
> > > >>
> > > >> Great, good to hear that :)
> > > >
> > > > I also got ofonod to work, with rather crazy hacks. But I now have
> > > > incoming/outgoing calls with GUI :-).
> > >
> > > Would you mind sharing those hacks - I would like to play around with
> > > ofonod as well. Maybe I can help with a way forward.
> >
> > Yeah that would be fun to play with :)
> >
> > Below is a patch that works better at least for ModemManager,
> > does anybody have ideas what the unused three ports might be?
> >
> > I wonder if ofono can use /dev/ttyUSB0 CQDM port?
> >
> 
> One of them can be used proprably to bridge debug for modem certification.
> This is usually disable for production device. The other could used for
> unsolicited response of GPS function if exists in this modem

OK so at least one of the ports is probably permanently disabled then.

GPS is there for sure, it can be accessed with at least mmcli with
ModemManager running assuming modem instance 0:

$ mmcli -m 0 --enable
$ mmcli -m 0 --location-enable-gps-raw
$ sudo chmod a+r /dev/cdc-wdm0

Then configure gpsd to use /dev/cdc-wdm0.

But having a dedicated NMEA port would be nice. Any ideas how the
GPS port might be enabled for ttyUSB, should it start just printing
out data if GPS is enabled?

FYI, selecting the "BP HW Diag & Boot AP" option from bootloader with the
volume buttons routes the whole modem to the OTG USB interface with
the same ports available to PC so that's probably for cert use.
If needed we can do this from Linux too by just by setting one of
the USB PHY pins high with cpcap_usb_gpio_set_mode().

Regards,

Tony
