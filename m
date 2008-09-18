From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Thu, 18 Sep 2008 15:05:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C4348928@dbde02.ent.ti.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
 <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo>
 <200809121216.27116.david-b@pacbell.net>
 <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo>
 <20080912193534.GH7132@frodo>
 <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com>
 <20080914185721.GB6943@frodo>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_5A47E75E594F054BAF48C5E4FC4B92AB02C4348928dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45488 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477AbYIRJf4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2008 05:35:56 -0400
In-Reply-To: <20080914185721.GB6943@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--_002_5A47E75E594F054BAF48C5E4FC4B92AB02C4348928dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felipe, Paul,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org On Behalf Of Felipe Balbi
> Hi,
>=20
>=20
> On Mon, Sep 15, 2008 at 12:11:46AM +0530, Pandita, Vikram wrote:
> > The issues mentioned are _not_ of omap34xx silicon, but of=20
> > the PHY (ISP1504 in SDP-USB expansion board).
>=20
> Gotcha
>=20
> > Better still is to move the PHY issues to platform/board specific funct=
ion.
> > Will try to submit a patch on that.
>=20
> sounds good to me ;-)
>=20
> If you can make your patch on top of the ones I have queued for sending,
> I'd be glad. Also, if you could test them for me, that would be quite
> nice since I only have a buggy version of beagleboard with one ehci
> port.
>=20
> I'm sending my patches attached for you, there's actually one from you
> supporting the new version of the expansion board.

Your patches apply fine, but when you insmod the ehci module, we go into
an infinite loop. Looks like some error reading a bit in CM_IDLEST2.

Attached patch removes the infinite loop for now and at least enumeration
can then happen. Ideally the clock framework should be taking care of
enabling DPLL5 when the corresponding clocks are enabled, but this does not
happen today.

@ Paul,
	Would it be possible for you to look at this please?

Regards,
Anand=

--_002_5A47E75E594F054BAF48C5E4FC4B92AB02C4348928dbde02enttico_
Content-Type: application/octet-stream;
	name="0005-omap-usb-ehci-dpll5-infinite-loop.patch"
Content-Description: 0005-omap-usb-ehci-dpll5-infinite-loop.patch
Content-Disposition: attachment;
	filename="0005-omap-usb-ehci-dpll5-infinite-loop.patch"; size=860;
	creation-date="Thu, 18 Sep 2008 15:03:35 GMT";
	modification-date="Thu, 18 Sep 2008 15:03:35 GMT"
Content-Transfer-Encoding: base64

UmVtb3ZlIGluZmluaXRlIGxvb3AgaW4gRFBMTCA1IHByb2dyYW1taW5nLiBJZGVhbGx5LCBEUExM
NSBzaG91bGQgYmUKdGFrZW4gY2FyZSBvZiBieSB0aGUgY2xvY2sgZnJhbWV3b3JrLgotLS0KIGRy
aXZlcnMvdXNiL2hvc3QvZWhjaS1vbWFwLmMgfCAgICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LW9tYXAtMi42L2RyaXZlcnMvdXNiL2hvc3QvZWhj
aS1vbWFwLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtb21hcC0yLjYub3JpZy9kcml2ZXJzL3VzYi9o
b3N0L2VoY2ktb21hcC5jCTIwMDgtMDktMTggMTQ6NTk6MzQuMDAwMDAwMDAwICswNTMwCisrKyBs
aW51eC1vbWFwLTIuNi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktb21hcC5jCTIwMDgtMDktMTggMTU6
MDA6MDkuNzM3NDc1NzU4ICswNTMwCkBAIC0xNzAsMTAgKzE3MCwxMiBAQCBzdGF0aWMgaW50IG9t
YXBfc3RhcnRfZWhjKHN0cnVjdCBwbGF0Zm9yCiAJCQkoNyA8PCBPTUFQMzQzMEVTMl9FTl9QRVJJ
UEgyX0RQTExfU0hJRlQpLAogCQkJUExMX01PRCwgT01BUDM0MzBFUzJfQ01fQ0xLRU4yKTsKIAor
I2lmIDAKIAl3aGlsZSAoIShjbV9yZWFkX21vZF9yZWcoUExMX01PRCwgQ01fSURMRVNUMikgJgog
CQkJCU9NQVAzNDMwRVMyX1NUX1BFUklQSDJfQ0xLX01BU0spKQogCQlkZXZfZGJnKGhjZC0+c2Vs
Zi5jb250cm9sbGVyLCAiaWRsZXN0MiA9IDB4JXhcbiIsCiAJCQljbV9yZWFkX21vZF9yZWcoUExM
X01PRCwgQ01fSURMRVNUMikpOworI2VuZGlmCiAJLyogRW5kIERQTEw1IHByb2dyYW1taW5nICov
CiAKIAo=

--_002_5A47E75E594F054BAF48C5E4FC4B92AB02C4348928dbde02enttico_--
