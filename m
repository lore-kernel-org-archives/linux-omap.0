From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: Add driver for OMAP UARTs
Date: Tue, 17 Apr 2007 20:06:40 +0000
Message-ID: <20070417200639.GG26287@atomide.com>
References: <20070409204433.GA23320@mail.solidboot.com>
	<20070412133710.GA9104@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070412133710.GA9104@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "George G. Davis" <gdavis@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* George G. Davis <gdavis@mvista.com> [070412 13:42]:
> On Mon, Apr 09, 2007 at 11:44:33PM +0300, Juha Yrj=F6l=E4 wrote:
> > +static struct uart_driver serial_omap_reg =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.driver_name	=3D "OMAP serial",
>=20
> You may want to reconsider ".driver_name" otherwise I suspect this may
> appear as:
>=20
> 	"/proc/tty/driver/OMAP serial"
>=20
> Yuck.  : )
>=20
> > +	.dev_name	=3D "ttyS",
> > +	.major		=3D TTY_MAJOR,
> > +	.minor		=3D 64,
> > +	.nr		=3D 3,
> > +	.cons		=3D OMAP_CONSOLE,
> > +};

Also one thing that needs to be verified is that using ttyS may
conflict with standard 8250 add-on ports, such as CF/PCMCIA modems
or bluetooth devices. At least it used to be that the non 8250 serial
ports must use a different name because of this issue.

Regards,

Tony
