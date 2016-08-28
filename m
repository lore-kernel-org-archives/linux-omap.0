From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Sun, 28 Aug 2016 07:35:05 +0200
Message-ID: <20160828053502.GA1601@katana>
References: <20160525141119.14486-1-rk@ti.com>
 <20160525141119.14486-2-rk@ti.com>
 <20160825171430.GM2856@katana>
 <CAALWOA-XP+mfTcVPc1LZZofAaCK-KtKhFKKKHu2PyHWFrfir3A@mail.gmail.com>
 <20160827172211.GA1601@katana>
 <CAALWOA8mtMAszBv6rcXdMzE_mRrrh-wmn6ECMJ32z4cJcfcOjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA8mtMAszBv6rcXdMzE_mRrrh-wmn6ECMJ32z4cJcfcOjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Ravikumar Kattekola <rk@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Making a mess of I2C controllers seems to be a popular hobby among
> chip designers :P

Well, I2C is simple, what could go wrong? :/

> A lot of the details (including the completely bizarre behaviour of
> its innocuous-looking irq registers) would be quite non-trivial to
> figure out without putting in a similar effort.

Thanks. So, it is possible to make a proper I2C slave with OMAP, but you
need to know those 100 gory details?

   Wolfram


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXwngGAAoJEBQN5MwUoCm2UUsQAKSqRRIjw8S8EP82ZYxFLgDh
G0NEmQhc71m+GQhCLgm1olMy/EFR/jc8R18VrUKg2N6uzHve1AJuPFuAJ08YW3bg
Qizn52e56cer/iZujji5aCUXpR6q8owCcVtCNgt8Ydggc99QkrZhT8QjvEEWm2eG
yugx+FIerZWy7hCwR0C5YfLMZ0s/0KKnzMuB8qgKNPX7RLDUbwK4i9ee+JcBh0Za
N/UBZcjlXro7Wxs3Vmss5ObRwYVzJeAMRU6SY5TBL+qWdnPc8l9KybahvhWyWgB3
fTMFyRdYP9cO7LkqHJiq6VQabdMK24FUZJ96z0lNvrU5+OPje4vvCQDzU3BdWlCC
CajJVHgUsO+ZubSidPXA53Xv7ZuD5wAmD3iu+zwpdqNygqNA6hy6TJKpULefqLhx
89V+IjVvgm74VIR6e3mrWxQehPdqys9qBsv8NkFLkzhbrWMulzmZcfhJ8zH6I2sT
IT2pHefHOLeLqDo8egSMcqZdpR+pO+LEQ9JPXEkQ016sWzFUy39jsEpRRiyzUBv4
wSIEZGtKzLZ/ZZRot5Gpc+VR7HQ8fuHZS4ojz4rqotDIj2nbo4QdoCWuYs5bxA2z
MKGItJWjG+pZnE6YqlWW/BF/ltgyZ0W7XUSRHOp9bdYezDRTNl8ilt0PB+ikO0Rk
4Pt/fHr0PVY4DOQ9lb4H
=yqte
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
