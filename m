From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 23 Oct 2012 20:51:23 +0300
Message-ID: <20121023175123.GB32517@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi>
 <5086CD91.9070101@firmworks.com>
 <20121023172035.GB32167@arwen.pp.htv.fi>
 <5086D91A.5080109@firmworks.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4671487114576664617=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5086D91A.5080109-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============4671487114576664617==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(please don't top-post)

On Tue, Oct 23, 2012 at 07:51:22AM -1000, Mitch Bradley wrote:
> Perhaps I misunderstood what you were suggesting.  I thought that, when
> you said "explicitly manage all their resources", you meant that the
> driver should know the platform-specific details about clocks and power
> domains.  That is one possible interpretation of the word "explicit".

we had two suggestions in the thread:

1) handle it in driver source code (explict)
2) handle at bus notifiers level (hidden)

archives would've helped you clear up that confusion ;-)

--=20
balbi

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhtkbAAoJEIaOsuA1yqREz2MP+wVOhQyD6TzW0tcGDMMS8MPH
ckHhQ8hdoyfwlMI+9z99Fc1ckwGAt6rcP8w6AQY4Pi9jNB1f9GMr8Yy2PAaS23MF
jtYTRnEUOHDfs1cehkXVts1fqc6aQnVw6quBEo0zmF9nO0dntvOSJahBoevaEgMi
S1D0PEtOeQw3FDnRSeYwizBndRtvBll24G1tZ8drI20J98pUXKl9nCeKIGkUtvl+
pkRPY0scJu+d00mVMu40vJZEDba6data70CxCnuoiySpIsb8nNDQ/2DtyoVJrCQB
kn+fcaDC06al+jP5Koa0VKBIYVKywhwpdTUiQs3N5uAx/781J5IGldV1xemZ9s2L
heQNx5HWjt3URgIf6jHyh2GBdfLmbH1LhIE+kxZNnYuc27EJqpYzS5UjnSkrUJ2Q
ghwfpdDGAVzyVys5sWv/h7xgZ2yV7VqtZqOhzd1ZM9QOjZ7JD6GXI6sPoka/zn1U
Bgci0/uaWpmXTEvc2zxBpz8vap58a15ONmSRz4QmkUYW+Pzz9+keWZ83xWBV1fMx
9Nz/Q24YETq6pybVqY98nN4Bk9xFukU04GpA8T+8wfBMNzE5q52b6uG5hmuloHNM
ov2YI9ONLetyUtFh0tpAu8Vq+eYmOX9YVtnhLoL472EVjngqRP7otvOv5hkQAlRG
QcZHo/D99ab33Es+0sFu
=Dt2e
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--===============4671487114576664617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4671487114576664617==--
