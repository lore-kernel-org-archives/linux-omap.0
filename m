From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/6] power: twl4030-madc-battery: Convert to iio
 consumer.
Date: Mon, 6 Apr 2015 19:39:27 +0200
Message-ID: <20150406173927.GE18145@earth>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426022847-30912-2-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Mar 10, 2015 at 10:27:22PM +0100, Marek Belisko wrote:
> Because of added iio error handling private data allocation was
> converted to managed to simplify code.

Thanks, pulled (only PATCH 1/6 for now).

-- Sebastian

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVIsTPAAoJENju1/PIO/qacLUP/i1pgrAJeevpRUYF5+cJ/8uS
3069C5RB78jD7cPJu3gMnttD2pDlg6ZU51KdR6AU+UIivOvBYv0kRsbAxYPHV6gj
h//7Bw2/1ZUIuPeN1z2myQt9BwTwlyUE3zrjfp4QPJ0CxzUKSdOq16tBYnKGWLCi
3Lx+Y7TIZt9yRYvQqAe9qHpxEAUGuND4ZkJaNDBCn/LgD8cVAd3hcROwSrzh88fZ
QqB+BHeEYrFx+ERa31KVc4STbYZHd6gzSBnVEk/k14N+PMSnr9rmNMNAR9odmJM7
ljcsIIlbmcGYvGZdkom+7z9cwoblN9uFeZh7P08AGGUn7mYzz4CqvH8w3BbRn9lY
zbHHVM8vnKaquQXXeiUbmUIOigUz8N5zKXn1WXY1xrDTxrHx/V0PPhmnOWYNt99S
Mk9sUtXaN43aGhRjDti3Jwbv+jyodMeMhY0/NqZcOPF7nz8twrx9pmJ1of3zkDWt
+rWjeHT5PeZhVTfie+bIRw4e7ghTUEBjmD2xIfD3jDtvqrA7DxuGWvlG0iWcEqPY
O6maNlvLK8pDTq1d62oFABIvHCU5hMtfrv8iQHqenZ/Hsj3sWU2VBRcgbnlx3ezD
TMxH1yWrF25OuZlMGvOuKCxYA/BIMzgKstI42QzDJMEIYUqheRBYCB8ItHKkSTlR
TCSi59ZV4f3Tpe5doLJq
=5skP
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
