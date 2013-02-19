From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH, RFC 1/8] ARM: localtimer: return percpu clkevt on register
Date: Tue, 19 Feb 2013 14:10:13 +0200
Message-ID: <20130219121013.GO23197@arwen.pp.htv.fi>
References: <cover.1361186097.git.afzal@ti.com>
 <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4607571987082558863=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal-l0cyMroinI0@public.gmane.org>
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
To: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Syed Mohammed Khasim <khasim-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============4607571987082558863==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline

--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 18, 2013 at 05:06:39PM +0530, Afzal Mohammed wrote:
> @@ -315,6 +315,7 @@ static struct local_timer_ops twd_lt_ops __cpuinitdat=
a =3D {
>  static int __init twd_local_timer_common_register(struct device_node *np)
>  {
>  	int err;
> +	struct clock_event_device *evt;
> =20
>  	twd_evt =3D alloc_percpu(struct clock_event_device *);
>  	if (!twd_evt) {
> @@ -328,8 +329,8 @@ static int __init twd_local_timer_common_register(str=
uct device_node *np)
>  		goto out_free;
>  	}
> =20
> -	err =3D local_timer_register(&twd_lt_ops);
> -	if (err)
> +	evt =3D local_timer_register(&twd_lt_ops);
> +	if (IS_ERR(evt))
>  		goto out_irq;

this is wrong. Will return 0 even in the error case. Correct version
would be:

if (IS_ERR(evt)) {
	err =3D PTR_ERR(evt);
	goto out_irq;
}

--=20
balbi

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI2ulAAoJEIaOsuA1yqRELJIP/12ken2QId8yUgcsrXQQLAZ8
haabqhcm54toRT3V6PcCVxfH71+h+KceD+lte/CMk/mYkfKjdraBUDiBvzqYSZbO
jbKx+f+C1k7iRIT/6JNxWqrikpaN1+Dfiu9yVTcJx8SuIq5ZHZ4Ep5Mm6J5udsQ3
iSl0fL/Ua3wQExkfEOMTG9KxHTNxCFTogIMO3ifizP9Rfu90kgTfALdQSv58wxtu
j9X9uyJmM7SEEOSgjKEtDOuecccVsFIvfMfNq7kvrN2ZfBOUUhFtAskq4NrTx0Dn
8BqmGHUK+8m6bJmglRlM8HwsGCc623XfhoVIQZ56FDX2+BNlqMt17LKVnUBdCcKm
y3czUBomoc3YnqlJ5oFaVlqH29//VmRIGyxYzzah/ROo6sZOXekEimFAXWwgmrQn
bIuaCtuOUGi2D77sxrgtJGMwko59k8rKjUSVLZaKFplJ7Ikqtnn9y2k8z9qMJbJV
/XcdPWtyhcGuTgDr1nWiXe+T46uODVz8tDwyad6bLfKHw/FvZ0Eu40vEuw6fXqv2
nmTh6PslKk/kcjM9sMv56wV30FzaNDFtxOQgKxzPHJ9lMonnhi8fF9CkiZaZxwUB
ZmRuZyUSu/9oeLZv4FoCJBEQrNyRPkCuKdT0Z70hZFTgvsCe2cGcvA2Q1Quu0Y0X
BT/OSjQTTCt6Iql6V+um
=ItBP
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--

--===============4607571987082558863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4607571987082558863==--
