From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 11 Jun 2006 08:09:59 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506200333@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: =?iso-8859-1?B?SnVoYSBZcmr2bOQ=?= <juha.yrjola@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > I picked up this encoding from USB which uses it also.  In general =
it
> > makes any kind of porting and sharing between some of our internal =
code
> > bases easier.  It has a nice property of also being more compact (in =
C
> > file coding space) then other forms.
>=20
> That encoding has a lot of downsides:
>=20
> - You're tied to accessing only one instance of the peripheral (trying
> to access e.g. the different GPIO blocks is bound to be ugly).

Yes that is true.  That's why it is not used there.  We generally have =
used it in things where there is 1 instance like PRCM.

> - You're tied to MMIO.  read_reg/write_reg can basically use whatever
> transport.

Probably.  Though as you say some preprocessor tricks can do wonders :)

> - As mentioned before, supporting several base addresses (e.g. on
> different OMAPs) becomes a hassle.
>=20
> read_reg/write_reg, in my opinion, doesn't.  You mention compactness =
as
> one, but with some preprocessor trickery it's rather easy to come up
> with a very compact read_reg/write_reg notation.
>=20
> But all in all, this is mostly a readability issue, and therefore
> subject to personal preferences.  Mine is read_reg/write_reg. =3D)

I do agree here.  Actually, I don't really mind if one form is used over =
another.  Easier sharing likely happens though yours, and consistency is =
better.  In general you do need to be a bit careful in that only =
focusing on an overall sharing strategy can limit you to the least =
common denominator.

The down side to me is we freeze and branch on a kernel version in =
support of customer release streams. Production is necessary.  When the =
kernel deviates from this it makes pushing back fixes (or taking them in =
harder).  Changes which are more on the cosmetic side hinder exchanges.  =
We do resynchronize as streams come up and also do some live tree =
tracking so things correct themselves after some time.=20

Regards,
Richard W.
