From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Mon, 2 Sep 2013 09:42:42 +0300
Message-ID: <52243362.3090905@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com> <20130813075449.GS7656@atomide.com> <52206A48.8040401@ti.com> <20130902061541.GU7656@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HKf5hWQ9rHjV8W2ujcCBUsh5bKL86b2cK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52710 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967Ab3IBGms (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Sep 2013 02:42:48 -0400
In-Reply-To: <20130902061541.GU7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--HKf5hWQ9rHjV8W2ujcCBUsh5bKL86b2cK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/09/13 09:15, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130830 02:55]:
>> On 13/08/13 10:54, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130809 01:46]:
>>>>
>>>> So as is evident, I have things in my mind that should be improved. =
Maybe
>>>> the most important question for short term future is:
>>>>
>>>> Can we add DSS DT bindings for OMAP4 as unstable bindings? It would =
give us
>>>> some proper testing of the related code, and would also allow us to =
remove
>>>> the related hacks (which don't even work quite right). However, I ha=
ve no
>>>> idea yet when the unstable DSS bindings would turn stable.
>>>>
>>>> If we shouldn't add the bindings as unstable, when should the bindin=
gs be
>>>> added? Wait until CDF is in the mainline, and use that?
>>>
>>> I don't think we should add any temporary bindings as it's going to b=
e
>>> a pain to support those in the long run. I suggest you initially just=

>>> stick to established bindings for the basic hardware IO address and
>>> interrupts etc, then those should still be valid with the generic pan=
el
>>> bindings later on.
>>
>> I don't understand what does it matter if the bindings are temporary, =
or
>> basic established bindings. In both cases the DT data needs to be
>> changed when the CDF is taken into use.
>=20
> Yes but the old bindings still need to be supported because people
> are doing devices using those. So any kind of temporary binding will be=

> a pain to support.

If old bindings need to be supported, then we also need to support the
current state for Panda and SDP, i.e. there are no DSS related DT
bindings, but displays still work. Which means we'll have to keep the
current hacky DSS device construction mechanism for Panda and SDP.

Although maybe it's cleaner to somehow inject the DSS DT nodes for Panda
and SDP in case they are missing from the real DT data.

Doesn't supporting old bindings also mean that we can never get rid of
the hwmods? Or will there be code that injects the missing interrupt
etc. entries?

>> Well, one difference is that the temporary bindings would give us
>> working display, but having only basic bindings would not. So I don't
>> see any reason to add only the basic bindings. Or how would it work?
>=20
> You might be able to use just a minimal binding for now using the
> basic reg, interrupt and entries for the various components. Those will=

> be still valid when the CDF bindings are available.

Well, the entries will be valid, but the displays won't work with just
the basic bindings. I could perhaps add a new hack that creates the
required panel devices and video pipeline connections dynamically in
code for Panda and SDP, a bit like what the code does now, except the
basic DSS entries would be in the DT. But that would just add another
set of DT data that I would need to support in the future, and there
would be three different cases to support for Panda and SDP:

- DT data with no DSS related nodes
- DT data with basic DSS related nodes
- DT data with full DSS

So... If old bindings have to be supported, I'd rather try to minimize
the pain, and not add anything but the final bindings. In retrospect, it
was a bit of a mistake to add the hacky DT display support for Panda and
SDP, as it won't be very nice to keep supporting those.

  Tomi



--HKf5hWQ9rHjV8W2ujcCBUsh5bKL86b2cK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSJDNiAAoJEPo9qoy8lh71l5wQAJS53uSEWuvnVIZHPmUG0lTu
dadY0fJF6ardnEyEb49TmkkKgp2tYrqTk9qW1cyQZ/I9XmmIed//9wwNDsAqG+C6
l9mfiIBTEfaKV0piGOT5wyEIvYROqEhOUawGrjQhTF0/Sm5nCgqEKAXwctXInJV5
S6NSRR6aBue8+fdswvUJ+M8x/4qqY/dGKmas1GdNsI4l75xhB+7whoVjL+YxUZpA
OhXFbAb/7xfwMu2j971eaKfCpYIfNoQm6w3CtkAisJd9OAVNTtYDqqK+Fz7WJsjc
nGNaxMNa7Flx8v1c0dy9VwhxJ06iJ+N9qHA2t1wIu/zti9Q8RSibL1Yq6HFvq9ST
SdyPpHbF5Mk92XRr+dsp0Ce3HCx0HmBG9iXvQl+lAX5KY1Bh6ds+W9xZJxlQ0L7x
+kzsrRU0kjNWx/4uqobpMx1XUueTJKfg7teIUw6ZOsrqt0eZO2sOTrveXy3e1OnX
NxK/iswAaX4iiClBAz6hN1XZQdGjUisGQgO/Z83j9b7RiIwuciz6tHnP/2Y6VKWd
5XR2LzY1ckpjxhdPuIGvGxQc8CaX/ma67Cmq+NNDy6/hGK0C5W5gyA7kPkA0R1vy
VjErMTTSiIDLgvnMLoIdK1YDDmOwR9tb78c0sWnvYN4umKoHF2JZsOgsq9QgY3Du
xtkrZYAcTJ1/QU60j6GS
=SiMp
-----END PGP SIGNATURE-----

--HKf5hWQ9rHjV8W2ujcCBUsh5bKL86b2cK--
