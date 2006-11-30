From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 15:49:14 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A508CE04CD@dlee02.ent.ti.com>
References: <200611301330.04176.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200611301330.04176.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> From: David Brownell [mailto:david-b@pacbell.net]
> I don't think the roll-over IRQ is significant in the new clock
framework,
> but I do think that the second MPU timer is important if there's a
chance
> of lost timer IRQs ... probably negligible at HZ=3D100, less so when =
the
> option
> of HZ=3D1000 is configured.
>=20
> Plus, ISTR that the upcoming generic dyntick support will need to
> reprogram
> the periodic IRQ, just like the current OMAP-specific code using
timer32k.

The only thing about using two timers which made me think twice was what
happens during retention/off mode sleeps.  This forces you to add a
little code to account for clock switching (sys_clk to 32KHz) at the
periodic timer, and adding knowledge about the stopped free running one.

Having a single GPT1 timer active which is wake up capable makes it all
simpler.  I did ask for a 2nd timer in the wake up domain and that
actually happened in 3430.

... Actually, I would guess many use cases would be find using a CORE
domain timer and setting the target for the system sleep to be
'request-idle' this removes any worry about the clock transition as the
functional clock of the CORE timer can run and its ISR can issue a PRCM
wake up.  This is the state you want to generally go into anyway in an
idle routine if you any kind of peripheral activity.

Regards,
Richard W.
