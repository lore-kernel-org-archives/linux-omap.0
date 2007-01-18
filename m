From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: 2430SDP LCD initialization and logo display during U-Boot time
Date: Thu, 18 Jan 2007 10:38:35 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4710DB77@dlee13.ent.ti.com>
References: <E8F32CF53D599A4F9F26D44E84E7B39D7388A6@dlee11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <E8F32CF53D599A4F9F26D44E84E7B39D7388A6@dlee11.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Katorgi, Maher" <mkatorgi@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I think you are talking about Splash Screen. We don't have this support
in 2430 u-boot.

The high level code does exists, we have to implement the OMAP DSS part,
it's easy to implement though :)

Regards,
Khasim

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Katorgi, Maher
> Sent: Thursday, January 18, 2007 9:54 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: 2430SDP LCD initialization and logo display during U-Boot
time
>=20
> Folks,
>=20
> Looking for code that initializes 2430SDP LCD and displays a bmp logo
on
> it during u-boot time.  Is anyone aware of such code and where can I
> find?
>=20
> Regards,
> Maher
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
