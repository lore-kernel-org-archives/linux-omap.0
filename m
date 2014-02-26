From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Wed, 26 Feb 2014 13:48:20 +0200
Message-ID: <530DD484.5040703@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
 <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8451189893934424629=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8451189893934424629==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="FehtNJi3Ppj594xmGTKHG8s8DfTELLXhA"

--FehtNJi3Ppj594xmGTKHG8s8DfTELLXhA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/02/14 21:30, Paul Walmsley wrote:
> On Wed, 19 Feb 2014, Paul Walmsley wrote:
>=20
>> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
>>
>>> This patch adds a simple method of rounding: during the iteration, th=
e=20
>>> code keeps track of the closest rate match. If no exact match is foun=
d,=20
>>> the closest is returned.
>>
>> So that's one possible rounding policy; maybe it works fine for a disp=
lay=20
>> interface PLL, at least for some values of "closest rate".  But anothe=
r=20
>> might be "only allow a selection from a set of pre-determined rates=20
>> characterized by the silicon validation team".  Or another rounding=20
>> function might need to select a more distant rate that minimizes jitte=
r,=20
>> EMI, or power consumption. =20
>=20
> Thought about this some more.  Do you only need this for the DSS PLL, o=
r=20
> do you need it for one of the core OMAP PLLs?
>=20
> If the former, then how about modifying your patch to create a separate=
=20
> round_rate function that's only used for the DSS PLL that implements th=
e=20
> behavior that you want?
>=20
> That would eliminate any risk of impacting other users on the system.  =
And=20
> would also allow this change to get into the codebase much faster, sinc=
e=20
> there's no need for clk API changes, etc.

The DSS internal PLLs are handled by the DSS driver, which does all
kinds of iteration to find good clocks. This patch is for a dedicated
display PLL, present on, for example, BeagleBoneBlack.

If you think that's better approach, I can take a look how it can be
done (I'm not too familiar with the clock framework). Or maybe there's a
possibility to have a flag of some kind, which allows rounded values to
be returned? That sounds like an easy addition too.

Note that the same change is needed for DT and non-DT boots. Having
separate round function would mean create a new clock "driver" (i.e.
compatibility string), wouldn't it? Adding a flag sounds easier.

 Tomi



--FehtNJi3Ppj594xmGTKHG8s8DfTELLXhA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDdSEAAoJEPo9qoy8lh71jXUP/0pMOC6Fm8DkJE1ZmrE1lvwe
o6jYoFd8yuDVvd9cA2WGnbPuiyjsuNY8qKD5CZNWghQevyViTzK8yB5k5tyGKD2Y
P/7c8woLpUiA95Qv8EGy4CN92/0l/WFtR/azDQkZTVXZNIVpC8zT1Y9Rw9nmkbHX
yrD+bZ+ai4O+L1X0QIgYhtarHiMaBduYWxImkY4eSxQNVl6fneycBbwiM8+Mmf9l
WEATIkK8ypMNajbNQ2hS6wLvKnDu1RE1uiP03DRx3OkBjKJaetsKRgum/ZeTLWQd
lqnVxYVQU6ctyG8iyjYOkMD1ZMT4uXER3OkiY7FaL9rnmxH2cX+TDW08Pmb2QQY/
s8fH5+N5FKvx0BpVv3qhWqPyB1YKoi463FnSGxqrkP4WoPTiDENQq2JR4q9OkJSi
NLRZrSUS0n7GGpC8WYowbR7si4MqsU2fjKynLKaMut5cG1nSVJRPR94hqzA2MKI+
+kxJxqYBGa+e1+ciXxT+OYdBmeQHGZd/cvatZO8N9qgjFlQyZzgC87jo3HYRkL9Z
X/ABF+n9sndZJkQjvFTJMb0QUJCFbiOXeeU9UMmQZ63vrSrmF20qy6kFXLsSsma4
6gTYuUaA73zFh57E5qYEU3rXneOUBPohYsj6FfYFvqFEw/3j47oLlziQe/4a7PuZ
/KXWf54oY7s3Klgw4wMg
=Cs24
-----END PGP SIGNATURE-----

--FehtNJi3Ppj594xmGTKHG8s8DfTELLXhA--


--===============8451189893934424629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8451189893934424629==--
