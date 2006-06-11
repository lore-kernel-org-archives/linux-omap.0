From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 11 Jun 2006 08:22:37 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506200337@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: =?iso-8859-1?B?SnVoYSBZcmr2bOQ=?= <juha.yrjola@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >
> > But all in all, this is mostly a readability issue, and therefore
> > subject to personal preferences.  Mine is read_reg/write_reg. =3D)
>=20
> I do agree here.  Actually, I don't really mind if one form is used =
over
> another.  Easier sharing likely happens though yours, and consistency =
is
> better.  In general you do need to be a bit careful in that only =
focusing
> on an overall sharing strategy can limit you to the least common
> denominator.

Actually, with respect to the PRCM I'd rather it stuck to what it =
current uses.

Along with my other biases I rationalized it this way... I like having a =
private driver incompatible method to access the PRCM.  It forces =
drivers to use API access functions and not directly access its =
registers.  The PRCM has more and more things to manage and having some =
xyz driver mess up its state behind my back will break everything.

For example I just sorted out why I was having some trouble getting to =
core retention on a particular 2430 configuration.  Some external entity =
had wrongly set and cleared a clock related bit.  This had the side =
effect of gating my ability to hit retention.  There were no status bits =
which warned me of this and it just didn't work.  The setting was in =
error and activated some half implemented logic in the chip...

There was a long time where I couldn't pull a reference open source port =
for OMAP and have its low level power work.  That is both a code and =
hardware issue.  It becomes very difficult to support pieces like this =
out side of production release streams as they stray.  I tend to favor =
functionally over beauty though I certainly can appreciate it when both =
converge.

Regards,
Richard W.
