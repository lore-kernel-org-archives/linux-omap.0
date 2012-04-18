From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by
	default
Date: Wed, 18 Apr 2012 16:02:09 +0100
Message-ID: <20120418150209.GO25053@n2100.arm.linux.org.uk>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com> <87vckyq6ti.fsf@ti.com> <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com> <87mx69nms2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87mx69nms2.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 18, 2012 at 07:21:33AM -0700, Kevin Hilman wrote:
> "Raja, Govindraj" <govindraj.raja@ti.com> writes:
>=20
> > On Wed, Apr 18, 2012 at 4:55 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
> >> "Govindraj.R" <govindraj.raja@ti.com> writes:
> >>
> >>> From: "Govindraj.R" <govindraj.raja@ti.com>
> >>>
> >>> The wakeups can be left enabled by default and should be disabled
> >>> only when disabled from sysfs and while entering suspend.
> >>
> >> Left enabled? =A0That assumes something else has initizlied them, =
but we
> >> can't make that assumption.
> >>
> >> First, wakeups should be disabled when ->probe has finished. =A0Th=
en,
> >> they should be enabled whenever driver is in use, and disabled whe=
n
> >> the driver is not in use.
> >>
> >> I'm not familiar enough with uart_ops, but it looks like they shou=
ld
> >> probably be enabled in uart_ops->startup and disabled in
> >> uart_ops->shutdown.
> >
> > uart_ops->shutdown gets called in suspend path also
> > serial_omap_suspend =3D> uart_suspend_port =3D > ops->shutdown(upor=
t);
> >
> > This will leave uart wakeup disabled in suspend path.
>=20
> As I said, I'm not familiar enough with uart_ops to know which are th=
e
> right ones.
>=20
> Maybe ->request_port and ->release_port are the right ones?

No, the clue's there in the name - these are supposed to be for resourc=
e
management.  They only get called when the port is first acquired by th=
e
driver, and released when the port is no longer required (iow, they
cover the span in time where the driver is capable of using the device.=
)
They don't tell you about the lifetime that the user has the port open.

> The point is that wakeups should be enabled whenever driver is in use=
,
> and disabled when the driver is not in use.

Well, we don't actually tell low level drivers that kind of detail (we
assume they're rather dumb - which maybe we shouldn't.)

It looks to me like there is the possibility of checking the TTY port
flags to see whether ASYNC_INITIALIZED is set - this will be clear in
->shutdown() method if the user is closing the port, otherwise it will
be set.  Same goes for the ->startup() method.

I'm not sure whether Alan would allow that kind of knowledge in low
level serial drivers though...
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
