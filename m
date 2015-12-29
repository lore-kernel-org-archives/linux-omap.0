From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Tue, 29 Dec 2015 15:55:45 -0600
Message-ID: <CAL_JsqLiuNR_MQ+eX_TQVMDtn85hUTweNRL2Q+7Z8Tq-HJhx2g@mail.gmail.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr> <20151229200244.GA27426@rob-hp-laptop>
 <1451424412.13576.1.camel@collins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451424412.13576.1.camel@collins>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 29, 2015 at 3:26 PM, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org> w=
rote:
> Le mardi 29 d=C3=A9cembre 2015 =C3=A0 14:02 -0600, Rob Herring a =C3=A9=
crit :
>> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
>> > LP872x regulators are made active via the EN pin, which might be h=
ooked to a
>> > GPIO. This adds support for driving the GPIO high when the driver =
is in use.
>> >
>> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
>> > ---
>> >  .../devicetree/bindings/regulator/lp872x.txt       |  1 +
>> >  drivers/regulator/lp872x.c                         | 33 +++++++++=
+++++++++++--
>> >  include/linux/regulator/lp872x.h                   |  2 ++
>> >  3 files changed, 33 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/regulator/lp872x.tx=
t b/Documentation/devicetree/bindings/regulator/lp872x.txt
>> > index 7818318..0559c25 100644
>> > --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
>> > +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
>> > @@ -28,6 +28,7 @@ Optional properties:
>> >    - ti,dvs-gpio: GPIO specifier for external DVS pin control of L=
P872x devices.
>> >    - ti,dvs-vsel: DVS selector. 0 =3D SEL_V1, 1 =3D SEL_V2.
>> >    - ti,dvs-state: initial DVS pin state. 0 =3D DVS_LOW, 1 =3D DVS=
_HIGH.
>> > +  - ti,enable-gpio: GPIO specifier for EN pin control of LP872x d=
evices.
>>
>> Should be "-gpios" instead of "-gpio".
>
> Care to comment why? There is only one GPIO that can be used here, si=
nce
> there is only one single EN pin. I thought this matched what is done
> already with "ti,dvs-gpio".

To be consistent. We use "clocks" and "interrupts" always whether one
or more for example.

-gpio is documented as deprecated now.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
