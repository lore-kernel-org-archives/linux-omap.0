From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap-serial: Request pins using pinctrl framework
Date: Thu, 6 Sep 2012 14:17:26 -0700
Message-ID: <20120906211725.GQ1303@atomide.com>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185832.1172.31013.stgit@muffinssi.local>
 <20120906195605.GA32145@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:15660 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759866Ab2IFVRa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 17:17:30 -0400
Content-Disposition: inline
In-Reply-To: <20120906195605.GA32145@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [120906 13:01]:
> Hi,
>=20
> On Thu, Sep 06, 2012 at 11:58:32AM -0700, Tony Lindgren wrote:
> > Request pins using pinctrl framework. Only show a warning
> > on error as some boards set the pins in the bootloader
> > even if CONFIG_PINCTRL is enabled.
> >=20
> > Cc: linux-serial@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
> >  drivers/tty/serial/omap-serial.c              |   10 ++++++++++
> >  2 files changed, 11 insertions(+)
> >=20
> > diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/a=
rm/plat-omap/include/plat/omap-serial.h
> > index 1a52725..0f4de14 100644
> > --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> > +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> > @@ -106,6 +106,7 @@ struct uart_omap_port {
> >  	struct uart_port	port;
> >  	struct uart_omap_dma	uart_dma;
> >  	struct platform_device	*pdev;
> > +	struct pinctrl		*pins;
>=20
> this won't apply to Greg's tty-next as I moved this structure to the =
C
> file :-s

Hmm the tty-next fails to build right now for omaps:

drivers/tty/serial/omap-serial.c: In function =E2=80=98serial_omap_set_=
mctrl=E2=80=99:
drivers/tty/serial/omap-serial.c:514: error: =E2=80=98struct uart_omap_=
port=E2=80=99 has no member named =E2=80=98DTR_gpio=E2=80=99

Maybe check how you want to fix that first? I can then update
my patch for tty-next.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
