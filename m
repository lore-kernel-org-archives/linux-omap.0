From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: tsc2005 touchscreen: implement disable attribute
Date: Sun, 9 Nov 2014 12:01:42 -0800
Message-ID: <20141109200142.GA37384@dtor-ws>
References: <20141109115636.GA3106@amd>
 <20141109124025.GA21763@earth.universe>
 <201411091349.20116@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201411091349.20116@pali>
Sender: linux-input-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, B38611@freescale.com, jg1.han@samsung.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 09, 2014 at 01:49:19PM +0100, Pali Roh=E1r wrote:
> On Sunday 09 November 2014 13:40:25 Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Sun, Nov 09, 2014 at 12:56:37PM +0100, Pavel Machek wrote:
> > > Implement disable attribute for tsc2005 touchscreen. It is
> > > useful to avoid wakeups when phone is in the pocket.
> >=20
> > I don't think this should be some driver specific sysfs node.
> > Instead a generic method from the input subsystem should be
> > used.
> >=20
> > -- Sebastian
>=20
> Yes. I would like to see generic method to turn off input device=20
> (or just "mute" it if device does not support turn off). Similar=20
> problem is also on laptops or other portable devices. E.g when I=20
> close LID of my laptop I want to turn off internal input devices=20
> (keyboard, touchpad, trackstick) without need to unload evdev=20
> Xserver drivers (or killing Xserver). Another use case is to turn=20
> off keyboard (also from kernel tty on Ctrl+Alt+Fx) which cannot=20
> be unplugged (internal laptop keyboard).
>=20
> CCed Dmitry, what do you think about it?

Actually I'd like it to be not limited to input devices but rater try
doing it at the device core level, if possible. I am sure there are IIO
and other devices that could be forcibly turned off/put into low power
mode under certain circumstances.

There were some talks about it with Rafael, but we never come with
anything concrete.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
