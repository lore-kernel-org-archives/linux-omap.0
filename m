From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] usb: phy: nop: Add some parameters to platform data
Date: Wed, 13 Mar 2013 16:17:52 +0100
Message-ID: <514098A0.1030809@ti.com>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com>
 <1363087466-32444-2-git-send-email-rogerq@ti.com>
 <513F177D.40500@pengutronix.de> <513F37DD.9030301@ti.com>
 <513F38DF.5040404@pengutronix.de> <513F3B7E.8000002@ti.com>
 <513F3EF0.3030609@pengutronix.de> <513F47B4.2060004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <513F47B4.2060004-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/12/2013 04:20 PM, Roger Quadros wrote:
> Adding Peter to the loop. I faintly remember him mentioning this issue be=
fore
> for beagle. We really need the deferred probe mechanism or we need to res=
ort
> to device registering order.

Yes, BeagleBoard is a good example. Long story short: we have external
dependency and the correct way to handle that is via deferred probe.

As of now we are not ready to kill the legacy support but over time we shou=
ld
move as much as we can to DT only mode.

> The first user for needs_vcc flag will be the beagleboard file. I just di=
dn't
> implement it in this patch [1].
> =

> On second thoughts, since [1] does work on beagleboard without requiring =
the
> needs_vcc flag, I think we can just live without it.

The BeagleBoard works because the bootloader happen to enable the PWM
generator which is used as a GPIO for the external HUB enable port. As soon=
 as
the bootloader stops doing this we are going to be in trouble.

> =

> Felipe, Peter, what do you think?
> =

> cheers,
> -roger
> =

> [1] https://lkml.org/lkml/2013/3/12/244
> =



-- =

P=E9ter
