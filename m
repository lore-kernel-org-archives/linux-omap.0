From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys: Support for one-directional
	interrupts
Date: Wed, 9 Dec 2009 09:58:31 -0800
Message-ID: <20091209175831.GD4456@core.coreip.homeip.net>
References: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com> <87fx7kgz7f.fsf@tac.ki.iif.hu> <6cb013310912090815u396fd84chfab3c7bf4d5f4bc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6cb013310912090815u396fd84chfab3c7bf4d5f4bc9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 09, 2009 at 08:15:26AM -0800, Cory Maccarrone wrote:
> On Wed, Dec 9, 2009 at 3:32 AM, Ferenc Wagner <wferi@niif.hu> wrote:
> > Cory Maccarrone <darkstar6262@gmail.com> writes:
> >
> > Interesting. =A0Btw. I'd like to convert gpio-keys from edge-trigge=
red to
> > level-triggered interrupts. =A0Would that work for your hardware?
>=20
> I'm fairly certain it wouldn't.  Each of the interrupts on my hardwar=
e
> has a corresponding bit in a control register that determines if it's
> rising or falling-edge triggered -- thus the need for my patch.  To
> capture both directions, it's necessary to modify the control registe=
r
> when a falling edge is detected, so that the corresponding rising edg=
e
> can be collected afterward.

This kind of ugliness should be hidden in irqchip driver. See
mfd/asic3.c for an example.

> May I ask why you're thinking of
> converting to level-triggering?
>=20
> Perhaps it would be better to provide an option in the platform_devic=
e
> structure to set edge- or level-triggering, similar to the change I'm
> proposing for interrupts that can only signal one way at a time.
>=20

Yes, we need a way fro platform code to specify desired interrupt flags
but I don't believe we should be reconfiguring them on the fly.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
