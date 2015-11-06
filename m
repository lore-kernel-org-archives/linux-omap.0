From: Felipe Balbi <balbi@ti.com>
Subject: Re: Linus HEAD build break
Date: Fri, 6 Nov 2015 08:40:44 -0600
Message-ID: <87vb9fyyvn.fsf@saruman.tx.rr.com>
References: <871tc31atk.fsf@saruman.tx.rr.com>
 <87y4ebyznc.fsf@saruman.tx.rr.com>
 <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8786921646091186563=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============8786921646091186563==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Belisko Marek <marek.belisko@gmail.com> writes:
> Hi,
>
> On Fri, Nov 6, 2015 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
>>
>> Hi again,
>>
>> Felipe Balbi <balbi@ti.com> writes:
>>> Hi Marek,
>>>
>>> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
>>> subnode") breaks build on current linus/master (which current sits in
>>
>> this commit cannot be found in next. How come it's in linus/master ?
> I did post fix but Tony seems doesn't merge it:
> https://lkml.org/lkml/2015/10/13/816

looking at that thread, I have no idea how come the old version was
merged in the first place. Tony was clear that it broke build and yet
this patch has made its way to mainline and it didn't even go through
linux-next, which makes the problem worse.

Now we have a bisection point where the tree (well, some DTS files)
won't even build. This is quite messy.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPLvuAAoJEIaOsuA1yqREzGoP/3sAorebftvyMAM1WkaO8wQj
ZOwnNa50I/Og1iN8dpJ/tkxSNfxmnS6FBPTcOd5DIf4MPBetyhvQQGI2fHIlC42E
ZhoDK8aqYdEnNaHrtWWXRG6ZPnyc040y8bHppZB8iX/6dBwqBToxr88945zXwEVV
OO5Qi2rB0vuJ4oMAcuE973tgrAWCCAkaBThPgbKKAyw4e1eCK6ebU0clkgK5aFiW
XDjkM+U9e9vPYxrrW/B3N3KxUzmMT6MdBatSCYytHnJ49DIoWKQHKv16DPW+/KFV
SlEPxw42+lCNXYrYMTBFaKho0UHn11AI6U9evI1z700zdxLBho2pervxmV1gVkrR
bKW1IjX7nIiPRklJ2AeS8Dpv9VybYfCPARPz8f3mS228szo++W7rFLfOUqw++VSH
IcWv+a4V9Z7dKga0RvTNngTwmMo3Xmj5Ez32KowFHdCLfz6tohvZZyM4aaBCOWI9
rUIxfN/bmNCuTOcgqp7bNYwVVM71QMUG6vHzRnDopLqI23bQK/Yy+ldejjP0ZJYc
sRP9ARbZNsCzErJaK1aQxTsyf9+rBnDID7lj276kE6Mseday+94JMrC9eDWSiwo6
tLaYPMotiWNO5CgQYl2NGsJWMCIrmMKKY1YtdGnK0eWn7ZKi+H2hUIsPXdFdlsfS
lDwdD94ksNr0lAOXN66j
=oLek
-----END PGP SIGNATURE-----
--=-=-=--


--===============8786921646091186563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8786921646091186563==--
