From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: omap5912 and regular DDR
Date: Thu, 15 Dec 2005 10:44:53 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5036C197A@dlee02.ent.ti.com>
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
To: Olav Kongas <ok@artecdesign.ee>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I'll give my disclaimer that I don't have an OSK. Nor did I look up the
module capabilities, So I really don't know.

I would guess it should support DDR and mDDR.  The initialization
sequence as documented in TRM's and DDR data sheets I've looked at are
slightly different.

OMAP2 DDR controllers defiantly are designed to support both though I've
only seen mDDR on boards which I use.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Olav Kongas
> Sent: Thursday, December 15, 2005 10:32 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: omap5912 and regular DDR
>=20
> Hi,
>=20
> omap5912 supports mobile DDR, OSK devel boards have it.
> However, it is unclear to me from omap docs, whether the
> chip supports regular DDR. Yes, I know, my questions should
> be destined to the TI support, but you know, I really have
> got real (omap) help only from this list.
>=20
> 1. Is regular DDR known to work on omap5912 (or known not
> to work). If it works then ...
>=20
> 2. is there anything tricky to get the regular DDR working
>=20
> 3. has anybody a working DDR initialization code for
> omap5912.
>=20
> Thanks in advance,
> Olav
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
