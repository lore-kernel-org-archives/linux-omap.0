From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] rtc: rtc-twl: use irq_of_parse_and_map helper
Date: Sat, 12 Nov 2016 12:20:10 +0100
Message-ID: <20161112112009.34gwcedl57v77ng5@earth>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-4-git-send-email-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vr2xnynlu3eayejn"
Return-path: <rtc-linux+bncBDXMLNOH5ANRB37VTPAQKGQEJPUVUKQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1478945246-32056-4-git-send-email-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--vr2xnynlu3eayejn
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

> Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/rtc/Kconfig   | 2 +-
>  drivers/rtc/rtc-twl.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)


This patch is missing long description. I would have patched it the
other way around. There is no reason to use irq_of_parse_and_map if
generic platform_get_irq can be used.

-- Sebastian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--vr2xnynlu3eayejn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlgm+ucACgkQ2O7X88g7
+pq3Uw/+I7VKFgSzpOlI+Y4WHX+xUm7fF+RcV5mert6L1IqQbnTwJa/f7vmzb77k
GBf1H0dwkA+AD12jkChXRYG7bfw2qiSgWBhKEO0sEEzxiAYCNBnQ+BF4OV3Hs0O7
CUSG4yfI7V66sL93yRz3xJ1YzJ2sXlUFR2eMQyzgVoKmve4Dbrhhi3hBGLf1eT45
ar3B6if+Qjz0jWicphWAtFXlJ33SOITNa9iNSDq8UNa6dvLnBsQN4u1NbFLHVWZQ
odPqfj7nL3hyl6BJCMBzL3rMhQL9Z1u9O0pAzYVw/3cwpgVJBsfyCqllwZObLAyw
SJRO9Byrea8PujFFuAa86Ydew59UgqOwQEafXzq48TqUB5sH9tUoaHK4E78jJ14B
xkW2aCd+LU6aSqfs8RCyXh8GIsbv3G6CgVeTdeSReEnutONsEgTufZj0W3vJHDII
T4fuAaaKQuCR8mXxOkN8sg+ajYQirJhYxi/4R3+sT3vbbaZEnEkspHuJ3Sny/6ta
dlbRoCq6beo0wXF5lpeG91MdnJ5Dv1eyp2jX5SGhDm0mC0p/+qQmNlGw61DhqgJl
5Q3V8Ngt7cLJNKp/IpDKgAFe3Yjkefj6txPhD/8BFm1qiNK8CbihXiu5fsux8m88
pDFmGQojD0T12MQriqBSnhFTWeFLbY+yDOJU8gUT1qqqQZGYGmU=
=t3di
-----END PGP SIGNATURE-----

--vr2xnynlu3eayejn--
