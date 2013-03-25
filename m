From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Tue, 26 Mar 2013 00:07:01 +0100
Message-ID: <2342477.1D1XZpYKqh@avalon>
References: <201302171616.50152@pali> <201303241519.49243@pali> <514F7419.4010104@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <514F7419.4010104@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sakari,

On Sunday 24 March 2013 23:46:01 Sakari Ailus wrote:
> Pali Roh=E1r wrote:
> > On Thursday 07 March 2013 23:18:27 Sakari Ailus wrote:
> >> On Wed, Mar 06, 2013 at 10:44:41PM +0100, Sebastian Reichel wrote:
> >>> On Wed, Mar 06, 2013 at 09:20:16PM +0100, Pali Roh=E1r wrote:
> >>>> On Wednesday 06 March 2013 21:12:06 Pali Roh=E1r wrote:
> >>>>> On Sunday 17 February 2013 20:03:03 Aaro Koskinen wrote:
> >>>>>> On Sun, Feb 17, 2013 at 04:16:49PM +0100, Pali Roh=E1r wrote:
> >>>>>>> +/*
> >>>>>>> + * arch/arm/mach-omap2/board-rx51-camera.c
> >>>>>>> + *
> >>>>>>> + * Copyright (C) 2008 Nokia Corporation
> >>>>>>> + *
> >>>>>>> + * Contact: Sakari Ailus <sakari.ailus@nokia.com>
> >>>>>>> + *          Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
> >>>>>>=20
> >>>>>> You should put these people to CC... Just to see if the addres=
ses are
> >>>>>> still valid (which I doubt).
> >>>>>=20
> >>>>> Ok, trying :-)
> >>>>=20
> >>>> I got "Delivery Status Notification (Failure)" for both addresse=
s.
> >>=20
> >> This is expected.
> >>=20
> >>> Sakari Ailus hosts some code on github [0], which has the followi=
ng
> >>> email address:
> >>> sakari.ailus+gitorious@retiisi.org.uk
> >>>=20
> >>> I added it to this mail's CC.
> >>>=20
> >>> [0] https://gitorious.org/~sailus
> >>=20
> >> Nice to hear people are interested in this. ;-)
> >>=20
> >> The primary reason I haven't tried submitting this to mainline is =
that
> >> ARM board code has a bad reputation these days. The N900 does not =
have
> >> yet support for device tree (AFAIK), which also would require a fe=
w bits
> >> and pieces on the flash driver to work.
> >>=20
> >> Also the sensor and lens drivers would need at least some work bef=
ore
> >> being ready for submission to mainline for camera to be usable.
> >> Unfortunately I haven't had recently time to work on this. N9(50) =
support
> >> has higher priority for myself. That, too, is pending the DT suppo=
rt for
> >> the device.
> >>=20
> >> There's indeed more up-to-date code in my repository. Even if it's=
 not
> >> too close to mainline anymore it should be a better starting point=
 than
> >> the old kernel from MeeGo.
> >>=20
> >> <URL:https://gitorious.org/omap3camera/pages/Home>
> >=20
> > Hi,
> >=20
> > this board code is same in your git repository and on meego obs.
> >=20
> > Patch only adding support for adp1653 driver which is already in up=
stream
> > kernel.
> >=20
> > Are there any other problems with this patch to go for upstream?
>=20
> A few more things comes to mind. We depend a little bit on actual boa=
rd
> code; it's not only static data. That's the configuration of the exte=
rnal
> clock from the ISP to the sensor. That should move to the common cloc=
k
> framework so that the ISP registers the clock and the sensor driver c=
an then
> use it. AFAIR Laurent has done some work on that.

Yes. I hope to get the patches in v3.10.

> The peculiar detail of the rx51 is that there's a switch on the camer=
a CCP2
> bus that selects either sensor (primary or secondary). Both sensors a=
re
> connected to the same receiver. That isn't properly modelled currentl=
y at
> all, so that's why we have rx51_camera_set_xshutdown(). I guess it'd =
still
> work if you only power (i.e. open) either of the devices at a time, t=
hough.

Have you thought about how we could model that ?

> That should be all.

--=20
Regards,

Laurent Pinchart
