From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: cross compiling for OMAP2430
Date: Tue, 17 Apr 2007 09:57:16 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429C8DC6F@dlee13.ent.ti.com>
References: <57314e840704170729if692d75h7a5229c7ebd7b136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840704170729if692d75h7a5229c7ebd7b136@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Gcc is a large thing which supports a lot.  The ownership of sub pieces
is distributed around.  You likely find many architectures are not in
phase with each other.  Places where specifications are ambiguous you
will find sub architecture even interpret things differently.  For
example is a 'char' signed or not is different across gcc.  Thus in
practice you will likely  match your tool set with an architecture and
perhaps even a specific kernel version.

Some commercial compilers which have central control do more of what
your imagining.  Even there you likely only get libraries for one
architecture at a time, not for every target.  That is unless you pay
for it.  GCC is free and decentralized. It is impressive in what it can
do given that.

Regards,
Richard W.=20

> -----Original Message-----
> From:=20
> linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.c
> om=20
> [mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linu
> x.omap.com] On Behalf Of Budhee Jamaich
> Sent: Tuesday, April 17, 2007 9:30 AM
> To: Kipisz, Steven; nishanth menon
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: cross compiling for OMAP2430
>=20
> Thank You Very much !
>=20
> My company actually bought these two books... still.. I=20
> cannot understand why arm-linux-gcc is needed - can't=20
> standard gcc compile for the ARM ?
> doesn't gcc have arm code-generator back-end ?
> I cannot find this in google...
>=20
> Thank You
> Budhee
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
