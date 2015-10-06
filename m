From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] ASoC: simple-card: Update clocks binding for
 simple-card DAI subnodes
Date: Tue, 6 Oct 2015 12:06:24 +0100
Message-ID: <20151006110624.GO12635@sirena.org.uk>
References: <1441977482-29215-1-git-send-email-jsarha@ti.com>
 <20150919184225.GR30445@sirena.org.uk>
 <56098BBF.2010700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bXlZHCxcr0Plg/YJ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56098BBF.2010700-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--bXlZHCxcr0Plg/YJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2015 at 09:49:35PM +0300, Jyri Sarha wrote:
> On 09/19/15 21:42, Mark Brown wrote:

> >What's the use case again?  Can we address this by converting the
> >relevant drivers to the clock API (or improving their clock API
> >support)?

> Sorry, I forgot to reply this earlier. The reason why we need this is the
> way McASP driver uses and provides clocks for different purposes. The most
> pressing need is to be able to select if we want to use some external clock
> pin as an input for McASP clock divider that produces the i2s bit-clock or
> if we want to use McASP's internal clock source.

> There are several other things this binding would allow us, and others with
> flexible i2s HW, to do. Some TI codecs would also benefit from a flexible
> way of describing the used clock configuration, but Peter know that part
> better.

> I tried to make the binding as flexible and generic as possible. But I do
> not currently see any immediate need for more than one set_sysclk() call per
> dai. I just did not see any reason to not allow it either.

This explains why you want to do this but what about the clock API
portion of the question - it would be good to move the ASoC clocking
more into the clock API, this would help integration with wider clock
trees.

--bXlZHCxcr0Plg/YJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE6svAAoJECTWi3JdVIfQWG0H/iD7490KZy14vzNcEab8fHYi
YXRar/5nTu+16vH+IYTiNBrsn1gObx5MAOn9kFEErUusOwuE5GvTAxDwuHyc5fzJ
pN4QxpP2m2k5v6r/eY120GMBejEYwjC8WFa2QSMUSlA+yDAavRwIzDHjd25QrfZi
3nh1dnv99iH3qOT45ENZuCT9tQc+9VHfID24oXMQMNvmeZifYuEHPmwx28s0LMtr
OeVBw7H5Ye4rIQ2IoFl1Zkc+jbYWlgSbDRlhCy7I4+ECU26Otr27oqXMd4981tzF
OyHHe/XLr6bOoAvq49uckz7ibDm4JsllV/aQyMGy95ymO+mENs0GHF4fYJVjYY8=
=6sAb
-----END PGP SIGNATURE-----

--bXlZHCxcr0Plg/YJ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
