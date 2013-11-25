From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5] usb: musb: dsps: indentation and whitespace fixes
Date: Mon, 25 Nov 2013 13:49:06 -0600
Message-ID: <20131125194906.GC18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-6-git-send-email-zonque@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fr7jhMP26BSURKlp"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385408393-19707-6-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Fr7jhMP26BSURKlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 08:39:53PM +0100, Daniel Mack wrote:
> Just a cosmetic thing, no functional change.
>=20
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_dsps.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 361ddf8..b27c072 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -131,9 +131,9 @@ struct dsps_context {
>  struct dsps_glue {
>  	struct device *dev;
>  	struct platform_device *musb;	/* child musb pdev */
> -	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
> +	const struct dsps_musb_wrapper *wrp;	/* wrapper register offsets */
>  	struct timer_list timer;	/* otg_workaround timer */
> -	unsigned long last_timer;    /* last timer data for each instance */
> +	unsigned long last_timer;	/* last timer data for each instance */
> =20
>  	struct dsps_context context;
>  };
> @@ -213,7 +213,7 @@ static void dsps_musb_disable(struct musb *musb)
> =20
>  	dsps_writel(reg_base, wrp->coreintr_clear, wrp->usb_bitmap);
>  	dsps_writel(reg_base, wrp->epintr_clear,
> -			 wrp->txep_bitmap | wrp->rxep_bitmap);
> +		    wrp->txep_bitmap | wrp->rxep_bitmap);

quite frankly, I don't what checkpatch.pl is trying to force here. I
much prefer a tab-only indentation, matching with ( characters forces us
to add some spaces. I would rather not take this patch.

--=20
balbi

--Fr7jhMP26BSURKlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk6myAAoJEIaOsuA1yqRE7jcP/18TQ3vmBytc/jcx0EwSTBmu
mxZGVjUQFVKj6It+bnMOFOc+C6iePwE9RiXqMt60f74w2zEX3z8okkutw+aIa2XE
DypYKve0hepOA6cbLRE2HfF/OVZ8lAos7F23STkKaBhLfHI/dg/76fiJjibmHhqP
UH58A4mCMJbyarfCDvXlBqTP/WElqcsbz/c6/z6lCPVcDTC2vtadMHnaUKc5vb27
HDsnioq+5iOCQpfOInX0VMch3G6sWHcoxo3EQ8NcVkCKOBERubOzxJmi4QEsS1Do
RlREcZ0dVOLc6ycerMRgtJ5Yi8VpF2qqW+JXbS8OVtencM8BBAs5Dn9y1qCQr9Uo
65bhkpMh3V6iCipmbaWDsDPz7sJsSe/LMsP27ycFeg4REEt6mHLT30thGe2rt2wm
0hcnkMiD3XpTIpvJnt9rO/k4zgtix13D10kxPyWf2sgTHPnoLp8sugib9qmurN1R
SH5tZKOPq0/qATOurmqdiyYobPFM/k5VjzkugIdaAoOHTAaGUH5Qj5WL6NrmBegg
V7yClCnefq7vCcKjoeyrIwa5PMaBsuzxTjX6e+nen4glD6wf/MdvkCRW67CvLTcT
JVcImB270m9QW10KP/uB7YMMekjKQU3rSFm7OQvMO5FAChya8Q+6kky6M95+Gt40
gVv4+DUzaY0Rcel6Wa01
=olyo
-----END PGP SIGNATURE-----

--Fr7jhMP26BSURKlp--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
