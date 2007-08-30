From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling
	viathe clock framework
Date: Thu, 30 Aug 2007 17:21:45 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901C5AECD@dlee13.ent.ti.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708210050330.5695@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD86A6@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708220312320.15587@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901B38ED9@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708270119440.17118@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0708270119440.17118@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > The OCP registers are in each modules address space.  An example of =
what
> > I was talking about is GTP1.TIOCP_CFG:0x48318010.
>=20
> Indeed, my mistake; not sure what register I was looking at when I =
wrote
> the earlier post.
>=20
> > On OMAP3 if you are using software control methods you may need to =
set
> > these in a particular way to ensure data has cleared before shutting
> > down the module.  I don't expect control at this granularity makes =
sense
> > for our typical usage, but if you are doing full hardware dependency =
for
> > idling it is relevant.
>=20
> Is this only if we set *_SYSCONFIG.AUTOIDLE to force-idle?

Yes that is the bit I was talking about in this case.

Regards,
Richard W.
