From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Wed, 20 May 2015 20:40:26 -0500
Message-ID: <20150521014026.GA16009@saruman.tx.rr.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <143211021.lFoirF2CMg@vostro.rjw.lan>
 <20150520021057.GT10274@atomide.com>
 <2273759.0pS9I3MzHs@vostro.rjw.lan>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44655 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbEUBmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 21:42:45 -0400
Content-Disposition: inline
In-Reply-To: <2273759.0pS9I3MzHs@vostro.rjw.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 02:54:14AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, May 19, 2015 07:10:57 PM Tony Lindgren wrote:
> > * Rafael J. Wysocki <rjw@rjwysocki.net> [150519 17:01]:
> > > On Tuesday, May 19, 2015 04:27:56 PM Tony Lindgren wrote:
> > > > * Rafael J. Wysocki <rjw@rjwysocki.net> [150519 16:07]:
> > > > > On Wednesday, May 20, 2015 12:41:06 AM Thomas Gleixner wrote:
> > > > > > On Wed, 20 May 2015, Rafael J. Wysocki wrote:
> > > > > > > This one looks really good. :-)
> > > > > > >=20
> > > > > > > If it doesn't depend on anything, I can apply it right away, =
so please let me
> > > > > > > know.
> > > >=20
> > > > Sure works for me, it just has a dependency to patch #1 in this
> > > > series ("[PATCH 1/5] PM / Runtime: Update last_busy in rpm_resume").
> > >=20
> > > OK, I'll queue them both up for 4.2, then.
> > >=20
> > > Please let me know if you need a special branch with them.
> >=20
> > A separate branch would be nice so I can merge that in too.
>=20
> OK
>=20
> I added a new pm-wakeirq branch to linux-pm.git with these two patches and
> one other commit related to runtime PM (all based on 4.1-rc4).  This bran=
ch
> will not be rebased going forward.

Hopefully it's not too late to get my

Reviewed-by: Felipe Balbi <balbi@ti.com>

in the patch. If it is, no problem :-)

cheers

--=20
balbi

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVXTeKAAoJEIaOsuA1yqREFPYP+gNaIcM1gYVi7UsHchb1fvD9
lm9s3UaU2s5aCBcK8vplts+s1G4HN4YmHQFlF8NgXw0IlGzL7fCAKCxvefZ5Wh4S
MhP9Of/HC8OwSVQKvl6qgfHWqSzfwQHOVpgyYOCKO/royRqUQ07CutBtzyQSHH4p
sGnZfH+TNG4bDdZTf/aMNxcpNQ1Wuvsgn96ISrZwcbKJws+dya+gAdDovPI4gWD8
Xl1ivIJbdtznbSG0Zpui81DW1rj9YdeMnV8Lr1rDwzVcmNCD/rznxtBOT/2xAUi/
e14VxHUIIfxAKcs3sKSkfG6BJV/+tUCJ+nLYeZgfLBuI7bEZ9bi3Y++gQaKnS26b
B9BPGBdi1xSjQnfmdFNFsNDPZ9cv6uU0q//3CcmFo6xaovtXkA4CHxfQprCQdI9e
kJ8T2k8AoaCgubpS1LIk++hMw0RNIDOabrLQ8OvG/MG1jmkqiw0HTM6FFA6MvKuU
fI3E7KSdLIAD5Z8nlg8XCnF4ox0aKTD9qE3smy0eC984RL8CBWwVlEgvlxsBvPmv
GevD5V8+e632aeYlaAFRITBi7J9S8dXuW7qvhr93LTs0KdTmZfggFqQxMBpsbHjf
uOm9Ie8NUaOui6h6dCN6d/RBZ23wXfFMrZ+q7+XKXESpfBf7J4dySVLhO78ePUUR
8B8X+FnpfT7xzTLzJ1rn
=/qf6
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
