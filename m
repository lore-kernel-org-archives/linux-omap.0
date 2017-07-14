From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: Droid 4 boot failure due to 422580c3cea7 (mm/oom_kill.c: add
 tracepoints for oom reaper-related events)
Date: Fri, 14 Jul 2017 19:23:43 +0200
Message-ID: <20170714172343.szrjbeob5alpgzpe@earth>
References: <20170714134330.bsdoopceecuk5yem@earth>
 <B9634541-43B8-45FD-8DD2-38FB4F0FAD14@fb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yqiy72hhiox5tx3b"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B9634541-43B8-45FD-8DD2-38FB4F0FAD14@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--yqiy72hhiox5tx3b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 14, 2017 at 02:12:21PM +0000, Roman Gushchin wrote:
> > On 14 Jul 2017, at 14:43, Sebastian Reichel <sebastian.reichel@collabor=
a.co.uk> wrote:
> > I just bisected another issue breaking boot on Droid 4. My
> > bisect points to 422580c3cea7 (mm/oom_kill.c: add tracepoints
> > for oom reaper-related events). It do not see any message
> > printed to UART (with earlyprintk) once that commit is part
> > of my image. Kernel config is below.

> This is really interesting, because this patch adds few
> tracepoints and all of them are called from the oom code, which is
> hopefully not a part of the boot process.
>=20
> Can you, please, confirm, that it can be reproduced with some
> confidence? If so, can you, please, eliminate the tracepoints
> calls and try to reproduce the boot failure?

I can boot 9967468c0a10 ("Merge branch 'akpm' (patches from
Andrew)") after adding

 - http://git.kernel.org/tip/19d39a3810e7032f311ef83effdac40339b9d022
   (another issue, that breaks Droid 4 boot)
 - a git revert of 422580c3cea7

OTOH there are strange problems. Using da16dd9785f8 + above
two commits also works. Using b5e16170f59b + above commits
does not work and bisection ended up in the merge commit.

-- Sebastian

--yqiy72hhiox5tx3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllo/hwACgkQ2O7X88g7
+pq20Q//SY3CTVn/VkmgxWsFosDcJSMt3YwSRnuw1Qt+5ogQ8KKHT/37IKTmvTWu
WmaWq4Yfzg6iBrdq93pd5SnqOxYu20Re/UtoieHcQofDtwV/pffylJYSDeMpEISK
p8DaOQhCvj09ZYnZNbVMl/N0msI7wHa1iyca+Tq40JhkcfyyUM6r6W7ACxn63itn
1zve79knSiZACksyGvk1AHBWjm3sntVGqIHecDvgkQw/9TR2mGTbx7kkIz+GENdZ
+AJxyG9QGr40oLPrdOaR2566E3AGEv4LJO/YNcYEvdWx0go/4nqlNVhrnFF/rmss
z0wv3GAhhkuCQSo3ZVMKx1SJNQucoVqJp2kk9eXukx055PPccOWWGffrRcXT2jUg
aU9drJ8FYK3VAI55U086erhelX9Bac7wdNPjqIaiaP6UzOZQ5TycHaKuc5tEA50E
VPYw/akTITGUsB4xPLPWXfisTGIGjua+yTrORVWpzfy5MRGIDMU181v7HXT5xJGa
c2FkClti+y/XZGkQA0diaH5DjDNGisstitN/E9vyvpNKZH9gMD0KCQx+BS6FMsEa
0QvAUknN4kVYg3bw1W99LMQo47J8YkvYVY6jbw053fpJgGsfIzpgwDnpgiwK5alx
H0GVAl17gG9DAHf5RLP0+qAwkgZq3Q0juqSAXB4DWrzPqqYb5As=
=jkN4
-----END PGP SIGNATURE-----

--yqiy72hhiox5tx3b--
