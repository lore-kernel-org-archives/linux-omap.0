From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [ANNOUNCE] TI DaVinci git tree available
Date: Sat, 27 May 2006 08:59:46 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A505EAA426@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > - There's also hack to the 8250.c serial ISR that used to be needed
but
> > is no longer needed on DaVinci.  It seems some mainline fixes have
> > removed the need for that.  I'm curious if it's still necessary on
OMAP.
>=20
> I assume you mean this chunk?
>=20
> @@ -1372,7 +1372,8 @@
>=20
>         DEBUG_INTR("end.\n");
>=20
> -       return IRQ_RETVAL(handled);
> +       //return IRQ_RETVAL(handled);
> +       return IRQ_HANDLED;     /* FIXME: iir status not ready on 1510
*/
>  }
>=20
> I'll see if things work now without that.

Last time I tried it didn't work with out it.  I did send Tony a patch
which may have fixed it.  Where are you at with those patches anyway
Tony?

The serial bit was a bug with respect to watermark handling and status.

On a side note to the above, I have recently unearthed a 15/16xx era
defect where the uart interrupt line could stay asserted some 6interface
+ 6functional cycles after a source condition clear, given certain clock
ratios.  Its possible DaVinci either uses a fixed version of the IP or
they just are not running at a clock combination which brings the
condition out.....or it could just be a software bug.

Regards,
Richard W.
