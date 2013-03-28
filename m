From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Thu, 28 Mar 2013 18:48:34 +0200
Message-ID: <51547462.3070803@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <51546259.3000704@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFEC71804184A0CA2C766F8AA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536Ab3C1Qsm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 12:48:42 -0400
In-Reply-To: <51546259.3000704@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

--------------enigFEC71804184A0CA2C766F8AA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-28 17:31, Igor Grinberg wrote:
> On 03/28/13 14:48, Tomi Valkeinen wrote:
>> So here are the DSS related board file changes for 3.10.
>>
>> First there are a bunch of patches adding the Kconfig options so that =
only one
>> display device is created for a single video bus. Only Overo had more =
than two
>> displays on the same bus, but unfortunately there were multiple boards=
 with a
>> setup that puts an LCD and DVI output on the same video bus.
>=20
> Hmmm, so basically, if one could switch the display at runtime...
> This cannot be done anymore...
> This sounds like feature removal, no?
> I know several of our clients who used this feature
> (at least for evaluation purposes).

At some point in time it was possible to have multiple displays for the
same bus, and switch them at runtime.

Sometime later it was changed so that the board file adds all the
displays, but only one (per bus) is actually added to the list of
panels, but you could still set the default display in the kernel args,
and thus you could select which display gets added.

The reason why the multiple-displays-per-bus is problematic is that the
video bus cannot be shared, and if we have multiple devices on the same
bus, the drivers need extra trickery, delaying initializations, etc, to
handle this. And it still doesn't work right, as it's easy to get two
displays enabled at the same time, configuring the same video bus,
creating a mess.

Quite often the case is that the other displays are not even present
physically. But it is true that some boards have gpio switches that can
be used to change the display during runtime.

> Is there any strong pros you obtain while removing this feature?

For an user, only indirectly. The change will make things sane on the
display side, and will thus make it much easier to proceed towards DT
adaptation, and Common Display Framework. While I can't say it's a
strict must to remove this feature, I can say that it's been a constant
headache for me for, well, ever. And I presume CDF would not have this
feature anyway, as it's rather bad design.

>> So the ifdeffery is not very nice. But, as discussed, this is the best=
 way
>> forward, and should be seen as a temporary solution until we get full =
DT
>> support.
>=20
> I've missed this discussion, can you please point to it?

Well, not so much discussion, but a few mails under "Display related
board specific boot args" subject on l-o. I proposed a board specific
kernel argument to select the displays present, Tony was less than
enthusiastic about that.

> And what will change with full DT support?
> Will we be able to define several displays through DT and
> select and active one during runtime?

No, not as such. DT will let the bootloader pass the DT data, thus
telling which displays are present. So we can have single kernel binary,
which will work for all the cases.

Dynamic switching during runtime will still be missing. For that I think
we need board specific drivers. That driver should know about board
specific restrictions etc (which are rather missing currently), remove
the old display device, and create the new one.

Well, actually, if there was a way to add a device while somehow marking
it so that no driver will be bound to it... Then the user could use the
standard sysfs interface to bind a driver to the device. I wonder if
that could be done...

 Tomi



--------------enigFEC71804184A0CA2C766F8AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRVHRlAAoJEPo9qoy8lh71FqgP/RQNNVM80qroVYJsN1IyeVqR
NitOnti3KkPIbOXG3JXtvuCn84orsSekvbOj1ENk1e2GSu8z0Mvn96dct8ZLD0rV
u/XMBsLkvP2BBsg3VR4OSSKRx32Lk/ieXDs+8MoeuZJmfVo3Y5wUFsib7RYga5ix
RdUhjXkos31bCJ36wiHqbyWR+rcs8d+q84lGvPStIntBF41cviiDoVYeccjHdO8k
IxFvyED154BXfwSSa9/b9virO2zro5FI+B/9ZJJi9+MQ2+J9aIWANbXHXZ7O/Cto
y+TpWsTPn7nSNFmIMCF/wUP/++oW0UEarrZT+c4kqdWE2hAfQAFWIryct3MWQFvw
ZxJAKttrIXo9t1+Jjb56sPBd3/eH8Jd7kkmJFuhBzeO6vNvmQdjZRTmkcmfXZm1z
eP9lIDMai6U3ZlvzZsPwQJH5bTtZa3hxn2L4L1cRdCVZG8hI3HuWP6PNEjwZ631V
rQRquM23HiWlcikutrSUgyxWyf5Qf2aAuv66EvnvEcbFEdHj76/Rd5joKJ5ZWxzH
e36MzL9/OXgt1FGH+zJEIAw8MO6OAUBjBvsMGNIYRzUGeTQNE3cr3ojDQ7aUnwR0
2bJ0IADG+vFrxRfEAC6eQn5J98NhepLLrlhlB+u2V2vEQ4+j5y6fzcNXMlh2QfMJ
F3Cy89RaJZtEjBZ471Sg
=fIuE
-----END PGP SIGNATURE-----

--------------enigFEC71804184A0CA2C766F8AA--
