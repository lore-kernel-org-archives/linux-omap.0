From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 15:25:24 +0000
Message-ID: <CAOf5uwnF8qTqX9O6s226=Nd4FbGjGev4LDonovgoXtoEH9QdVA@mail.gmail.com>
References: <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd> <20180329164113.GR5700@atomide.com>
 <20180329184007.GA27688@amd> <20180329215612.GS5700@atomide.com>
 <20180330103744.GA17404@amd> <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
 <20180330152227.GU5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180330152227.GU5700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Dan Williams <dcbw@redhat.com>, Merlijn Wajer <merlijn@wizzup.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, kernel@collabora.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Fri., 30 Mar. 2018, 11:22 pm Tony Lindgren, <tony@atomide.com> wrote:

> * Merlijn Wajer <merlijn@wizzup.org> [180330 13:09]:
> > On 30/03/18 12:37, Pavel Machek wrote:
> > > On Thu 2018-03-29 14:56:13, Tony Lindgren wrote:
> > >> * Pavel Machek <pavel@ucw.cz> [180329 18:41]:
> > >>> Thanks. I got call working including outgoing audio: in capture
> > >>> settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
> > >>> the other phone muted, so I don't yet know if such call would be of
> > >>> usable quality.
> > >>
> > >> Great, good to hear that :)
> > >
> > > I also got ofonod to work, with rather crazy hacks. But I now have
> > > incoming/outgoing calls with GUI :-).
> >
> > Would you mind sharing those hacks - I would like to play around with
> > ofonod as well. Maybe I can help with a way forward.
>
> Yeah that would be fun to play with :)
>
> Below is a patch that works better at least for ModemManager,
> does anybody have ideas what the unused three ports might be?
>
> I wonder if ofono can use /dev/ttyUSB0 CQDM port?
>

One of them can be used proprably to bridge debug for modem certification.
This is usually disable for production device. The other could used for
unsolicited response of GPS function if exists in this modem

Michael

>
> Regards,
>
> Tony
>
> 8< -------------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Sun, 19 Nov 2017 19:55:56 -0800
> Subject: [PATCH] USB: qcaux: Add droid 4 mdm6600 modem
>
> We have five USB ports on mdm6600 modem and does not have the same
> layout as layout as Gobi 1K/2K/etc devices listed in qcserial.c
>
> So we should not be adding them to qcserial.c but instead use
> qcaux.c or option.c as noted by Dan Williams <dcbw@redhat.com>.
>
> The ttyUSB ports detected by ModemManager are:
>
> ttyUSB0 CQDM-capable
> ttyUSB1 no response
> ttyUSB2 no response
> ttyUSB3 no response
> ttyUSB4 AT-capable
>
> Note that it takes a while for ModemManager to start while it's
> detecting the ports, so we may want to eventually limit the ports.
>
> So far no luck finding out what the unused three ports are, maybe
> there is NMEA there if somebody knows how to enable it.
>
> Signed-off-by: Tony Lingren <tony@atomide.com>
> ---
>  drivers/usb/serial/qcaux.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/serial/qcaux.c b/drivers/usb/serial/qcaux.c
> --- a/drivers/usb/serial/qcaux.c
> +++ b/drivers/usb/serial/qcaux.c
> @@ -66,6 +66,7 @@ static const struct usb_device_id id_table[] = {
>         { USB_VENDOR_AND_INTERFACE_INFO(UTSTARCOM_VENDOR_ID, 0xff, 0xfe,
> 0xff) },  /* WMC */
>         { USB_VENDOR_AND_INTERFACE_INFO(UTSTARCOM_VENDOR_ID, 0xff, 0xff,
> 0xff) },  /* DIAG */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x1fac, 0x0151, 0xff, 0xff, 0xff)
> },
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x22b8, 0x2a70, 0xff, 0xff, 0xff)
> },
>         { },
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);
> --
> 2.16.3
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
