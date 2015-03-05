From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 15/15] twl4030_charger: assume a 'charger' can supply
 maximum current.
Date: Thu, 5 Mar 2015 17:45:03 +1100
Message-ID: <20150305174503.7b3d33cc@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043353.4243.7374.stgit@notabene.brown>
	<20150302212939.GS13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/66DH9VJ=jVsyxIQu3ZYHzbd"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302212939.GS13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/66DH9VJ=jVsyxIQu3ZYHzbd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:29:39 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 15:33:53, NeilBrown wrote:
> > If it cannot, we will stop pulling more current when voltage drops.
>=20
> Can you justify it a bit more?
>=20
> I mean... maybe there's a fuse in the charger? Or maybe it will supply
> the current but overheat in the process? (USB_MAX_CURRENT is 500mA or
> 1.7A?)

USB_MAX_CURRENT is 1.7A - the most the twl4030 will manage.

The relevant specs say that a charger can deliver from 0.5A to 5.0A at betw=
een
4.75 and 5.25 volts.
They don't, as far as I can tell, describe how a gadget can determine where
in those ranges the charger is actually happy.

My understanding of electronics suggests that if you start to pull too much
current, the voltage will start to drop.  It is that voltage drop across
internal resistance which causes over-heating.

So if voltage is above 4.75 volts, it seems reasonable to assume that the
charger is happy.

The code currently (see previous patch) ramps up the current until the
voltage drops below 4.75, or until the maximum is reached.
If the voltage drops, it backs off.
The current should  only be too high for 100ms.  Hopefully not too long.

I'm very open if anyone can suggest a more safe way to make full use of a
charger without risking excess current draw, but I cannot find one.

Maybe I should measure the unloaded voltage, and not let it drop more than
0.25V below that?

I'm also very open to someone finding out how to get the twl4030 to detect a
"D+ and D- shorted" charger.  I think it is supposed to be able to do this,
but I haven't managed to make it work yet.

Thanks,
NeilBrown


--Sig_/66DH9VJ=jVsyxIQu3ZYHzbd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPf7bznsnt1WYoG5AQLqlxAAv+53f/cWhIYqGZw3xLOfQCI4TZXaVux2
FhCkEOY3rKMkKLOX8aCq/ZnxXM2/1VGTnuHVREH0zYo95aSZxKA5hGEeZtr0KbJD
pG3XvNUfeTr6lA8bEc00ViOm5TCX87y5GstscEfeA6/2AhuHwXf3rP2ZJm9C2pVP
CwxptQiQe/DzVR64JAOitZ89mEm736XmqgyfokqvToYlHY0nLGLPF7t65rALuFVD
zwoyVmoEydEsMMgHHDto+PnyxAwSzjY2gn5su2wFxGYXeY+H+mPXert1UHJ0YEEc
YK+LLEzOKDpCYwGrqsKR5RLiJSA0S0TVsgzXavIP8/fg2iviXQSw92FcSpwb9uBo
1Fm3KFgabnJKpPrZ4LmdItTqoS4waS84drL6V9miguD/Z0GML9OjSk66qOQWYWOF
C1GeVqhkhTVm0yXJN6XsWOzM4esNgcT+p4juJPOLX5XZ3+BPzQOkiTSjVc4B6b/f
wJxYKmJbk9u3qU06DfoTxKl1Iv/tQB0c/E7wGSqMFJpOlyjAVCxwxwnpYNaezJl3
PzLtEwJYGEWgJxrELVOMyFYzpUeC5Ll/r+Q9hGxo/h/rpCJ85URUIhzAa51vWix7
TaeqW1YWsZ3wxV3KFNRziTNqld07wIVOJPfFKwOAE9odW3Qq3DjRBDru8Uzkjx3C
mNp3CAdNHd4=
=6nOs
-----END PGP SIGNATURE-----

--Sig_/66DH9VJ=jVsyxIQu3ZYHzbd--
