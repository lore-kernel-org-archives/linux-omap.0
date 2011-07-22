From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv5 01/11] OMAP: prcm: switch to a chained IRQ handler
 mechanism
Date: Sat, 23 Jul 2011 02:46:14 +0300
Message-ID: <20110722234612.GA13706@legolas.emea.dhcp.ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
 <1309861677-2769-2-git-send-email-t-kristo@ti.com>
 <87bowlsz1p.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:38193 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462Ab1GVXqS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 19:46:18 -0400
Received: by mail-fx0-f43.google.com with SMTP id 17so5165473fxg.2
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 16:46:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87bowlsz1p.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 22, 2011 at 03:58:26PM -0700, Kevin Hilman wrote:

[snip]

> > -static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
> > -{
> > -	u32 irqenable_mpu, irqstatus_mpu;
> > -	int c =3D 0;
> > -
> > -	irqenable_mpu =3D omap2_prm_read_mod_reg(OCP_MOD,
> > -					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> > -	irqstatus_mpu =3D omap2_prm_read_mod_reg(OCP_MOD,
> > -					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> > -	irqstatus_mpu &=3D irqenable_mpu;
> > -
> > -	do {
> > -		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
> > -				     OMAP3430_IO_ST_MASK)) {
> > -			c =3D _prcm_int_handle_wakeup();
> > -
> > -			/*
> > -			 * Is the MPU PRCM interrupt handler racing with the
> > -			 * IVA2 PRCM interrupt handler ?
> > -			 */
> > -			WARN(c =3D=3D 0, "prcm: WARNING: PRCM indicated MPU wakeup "
> > -			     "but no wakeup sources are marked\n");
> > -		} else {
> > -			/* XXX we need to expand our PRCM interrupt handler */
> > -			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
> > -			     "no code to handle it (%08x)\n", irqstatus_mpu);
> > -		}
> > -
> > -		omap2_prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
> > -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> > -
> > -		irqstatus_mpu =3D omap2_prm_read_mod_reg(OCP_MOD,
> > -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> > -		irqstatus_mpu &=3D irqenable_mpu;
> > -
> > -	} while (irqstatus_mpu);
> > -
> > -	return IRQ_HANDLED;
> > +	if (c)
> > +		return IRQ_HANDLED;
>=20
> minor: insert blank line

actually, would be better to just use ternary here ?

	return c ? IRQ_HANDLED : IRQ_NONE;

--=20
balbi

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKgvEAAoJEAv8Txj19kN1h8YH+gIQ0gLvK6t/DfOnMS43REcR
0CkmGHY+LjKNPo7LsUyI5EQBu9q7w78Zen8Q2T13v+VVSulRSMN31ZW6jhZEsTMF
pMN3X0MpWsghkcMyFn4i0WyKIlYyD701DHS7oCs7bh3ichQPGzMO6tY9u4b6TA3A
tTr/ERtg2RGzbQTNhA3zHvQe2hjLsRvg1auK1CJZxgyXqmP+KNAMIQ2jZwTiOEX0
hqtagbvnJXl8vHAW7WrtDaihOqmDaC8s89XYtlbETDs2KyfjCA3WgFTy4xtr10GK
2TeYEj8zNPDRgKsTjW8L6HZ3HZzKvZ9HaktO1EPdFJtcP4gRFnXsZHrbfwH2RM0=
=GK9z
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
