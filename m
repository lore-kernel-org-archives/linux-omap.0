From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
Date: Thu, 5 Apr 2012 13:26:17 +0100
Message-ID: <20120405132617.76e04217@bob.linux.org.uk>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
	<CAMrsUd+_coW7ebuN_o=yZbbSVKnkx5R6=yHjUEUc0EcQGtgSRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMrsUd+_coW7ebuN_o=yZbbSVKnkx5R6=yHjUEUc0EcQGtgSRQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 5 Apr 2012 16:54:03 +0530
"Raja, Govindraj" <govindraj.raja@ti.com> wrote:

> On Wed, Mar 21, 2012 at 3:54 PM, Govindraj.R <govindraj.raja@ti.com>
> wrote:
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> >
> > Based on Linux-OMAP tree uart branch.
> > (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.gi=
t
> > remotes/origin/uart)
> >
> > * Removes the cpu checks wherever possible and use version reg
> > =A0for populating features and errata's
> > * enable tx wakeup available in wer reg for applicable
> > =A0module revision's
> >
> > Govindraj.R (3):
> > =A0OMAP2+: UART: Remove cpu checks for populating errata flags
> > =A0OMAP2+: UART: enable tx wakeup bit for wer reg
> > =A0OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap2=
4xx
> >
> > =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 13 +----
> > =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A08 +++-
> > =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 71
> > ++++++++++++++++++++++++- 3 files changed, 78 insertions(+), 14
> > deletions(-)
>=20
> Alan / Greg,
>=20
> With you ack on tty parts can this series be upstreamed from
> omap tree ?

=46ine by me - this seems primarily to be architectural details.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
