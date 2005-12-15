From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: omap5912 and regular DDR
Date: Thu, 15 Dec 2005 11:21:37 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402E30EDE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Olav Kongas <ok@artecdesign.ee>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Olav, Richard, =20

Unfortunately, I do not believe that we support this on the OMAP5912. My
understanding is that we only support regular SDR, mobile SDR and mobile
DDR. The description of the EMIFF interface in the data manual only
lists these. I also recall that we had said no to this in the past to
from another request.=20

Regards,
Jon


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Woodruff, Richard
> Sent: Thursday, December 15, 2005 10:45 AM
> To: Olav Kongas; linux-omap-open-source@linux.omap.com
> Subject: RE: omap5912 and regular DDR
>=20
> I'll give my disclaimer that I don't have an OSK. Nor did I=20
> look up the module capabilities, So I really don't know.
>=20
> I would guess it should support DDR and mDDR.  The=20
> initialization sequence as documented in TRM's and DDR data=20
> sheets I've looked at are slightly different.
>=20
> OMAP2 DDR controllers defiantly are designed to support both=20
> though I've only seen mDDR on boards which I use.
>=20
> Regards,
> Richard W.
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of Olav Kongas
> > Sent: Thursday, December 15, 2005 10:32 AM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: omap5912 and regular DDR
> >=20
> > Hi,
> >=20
> > omap5912 supports mobile DDR, OSK devel boards have it.
> > However, it is unclear to me from omap docs, whether the=20
> chip supports=20
> > regular DDR. Yes, I know, my questions should be destined to the TI=20
> > support, but you know, I really have got real (omap) help only from=20
> > this list.
> >=20
> > 1. Is regular DDR known to work on omap5912 (or known not=20
> to work). If=20
> > it works then ...
> >=20
> > 2. is there anything tricky to get the regular DDR working
> >=20
> > 3. has anybody a working DDR initialization code for omap5912.
> >=20
> > Thanks in advance,
> > Olav
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
