From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH 9/9] omap mmc host: Use disable_irq_nosync() from within
 irq handlers.
Date: Sun, 26 Apr 2009 21:21:18 +0200
Message-ID: <20090426212118.19526712@mjolnir.ossman.eu>
References: <1239861321.29831.130.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-16764-1240773681-0001-2"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756535AbZDZTVk@vger.kernel.org>
In-Reply-To: <1239861321.29831.130.camel@linux-51e8.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>, Anderson Briglia <briglia.anderson@gmail.com>, "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Ben Nizette <bn@niasdigital.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-16764-1240773681-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Should I queue this up or do you want to do something differently for
this?

On Thu, 16 Apr 2009 15:55:21 +1000
Ben Nizette <bn@niasdigital.com> wrote:

>=20
> disable_irq() should wait for all running handlers to complete
> before returning.  As such, if it's used to disable an interrupt
> from that interrupt's handler it will deadlock.  This replaces
> the dangerous instances with the _nosync() variant which doesn't
> have this problem.
>=20
> Signed-off-by: Ben Nizette <bn@niasdigital.com>
> ---
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 5570849..d5ea652 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -824,7 +824,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>  		del_timer(&host->cmd_abort_timer);
>  		host->abort =3D 1;
>  		OMAP_MMC_WRITE(host, IE, 0);
> -		disable_irq(host->irq);
> +		disable_irq_nosync(host->irq);
>  		schedule_work(&host->cmd_abort_work);
>  		return IRQ_HANDLED;
>  	}


--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-16764-1240773681-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkn0tDAACgkQ7b8eESbyJLhMjgCeIOsOCqpjAs8cLBQWxOG6RvLP
rYAAoNOgjanoctKCYgD78Ds/b5YTsiJK
=9vxk
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-16764-1240773681-0001-2--
