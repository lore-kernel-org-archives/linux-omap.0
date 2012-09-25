From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
Date: Tue, 25 Sep 2012 12:57:36 +0300
Message-ID: <1348567056.2342.28.camel@deskari>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
	 <1348554291.2342.8.camel@deskari>
	 <CAF0AtAukV_5FXXc79yuXr50+1XXWNiFKdN5MWLgRy2N6Ux-adg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-SbNWpPWqhfUoX2ZpWIu3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49332 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754510Ab2IYJ5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 05:57:42 -0400
Received: by lbon3 with SMTP id n3so104230lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 02:57:38 -0700 (PDT)
In-Reply-To: <CAF0AtAukV_5FXXc79yuXr50+1XXWNiFKdN5MWLgRy2N6Ux-adg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-SbNWpPWqhfUoX2ZpWIu3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-09-25 at 15:00 +0530, Mahapatra, Chandrabhanu wrote:

> > This debug message is even less meaningful than the overlay number =3D)=
.
> > Again, I think either keep the DSSDBGF, or print something sensible,
> > like "entering ULPS".
> >
>=20
> I dont think it would be wise enough to update code for one and keep
> the older version for another when both DSSDBG and DSSDBGF are almost
> one and the same. Its better to add something meaningful to the prints
> as you have mentioned like "writing ovl %d regs" and "DSI entering
> ULPS".

I didn't mean to leave DSSDBGF unchanged. I meant that it should work as
it works now, printing the func name, but using pr_debug.

> >>
> >>       WARN_ON(!dsi_bus_is_locked(dsidev));
> >>
> >> @@ -4184,7 +4180,7 @@ int omapdss_dsi_set_clocks(struct omap_dss_devic=
e *dssdev,
> >>       unsigned long pck;
> >>       int r;
> >>
> >> -     DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
> >> +     DSSDBG("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
> >>
> >>       mutex_lock(&dsi->lock);
> >>
> >> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/d=
ss.h
> >> index 5e9fd769..3a2caab 100644
> >> --- a/drivers/video/omap2/dss/dss.h
> >> +++ b/drivers/video/omap2/dss/dss.h
> >> @@ -29,38 +29,20 @@
> >>
> >>  #ifdef DEBUG
> >>  extern bool dss_debug;
> >
> > You still left the dss_debug option here, even if it's not used by the
> > DSSDBG anymore. What's your plan about this?
> >
> >  Tomi
> >
>=20
> dss_debug and DEBUG need to remain here as it is being used by
> functions omap_dispc_irq_handler() and _dsi_print_reset_status() in

It would be good to clean all this in one patch series.

> dispc.c and dsi.c. I am little bit unsure of how to deal with it.
> There could be a single print in omap_dispc_irq_handler() but it is a
> bit tricky in _dsi_print_reset_status().
>=20
> May be a macro like this one can be used in _dsi_print_reset_status()
>=20
> #define DSI_FLD_GET(fld, start, end)\
>       FLD_GET(dsi_read_reg(dsidev, DSI_##fld), start, end);
>=20
> pr_debug("PLL (%d) CIO (%d) \n PHY (%x%x%x, %d, %d, %d) \n",
>                  DSI_FLD_GET(PLL_STATUS, 0, 0),
>                  DSI_FLD_GET(COMPLEXIO_CFG1, 29, 29),
>                  DSI_FLD_GET(DSIPHY_CFG5, bo, bo),
>                  DSI_FLD_GET(DSIPHY_CFG5, b1, b1),
>    ..................................................);
> This could be defined at the beginning of the function and later at its e=
nd.

Yes, I think something like that could work. I don't see any problem
with having temporary helper macros to help creating the debug message.

> As you had previously mentioned a print like
>=20
> #define PIS(x) (status & DSI_IRQ_##x) ? (#x " ") : ""
>=20
> pr_debug("DSI IRQ: 0x%x: %s%s%s",
>         status,
>         PIS(WAKEUP),
>         PIS(RESYNC),
>         PIS(PLL_LOCK));
>=20
> could help in print_irq_status() but I am still unsure how to deal
> with conditional statements in print_irq_status() like
> if (dss_has_feature(FEAT_MGR_LCD3))
>                 PIS(SYNC_LOST3);
> Should we use approach like
>=20
> pr_debug("DSI IRQ: 0x%x: %s%s%s%s...",
>         status,
>         PIS(WAKEUP),
>         PIS(RESYNC),
>         PIS(PLL_LOCK)
>         dss_has_feature(FEAT_MGR_LCD3) ? PIS(SYNC_LOST3) : ""
>   ...................................... );

Yes, that looks fine to me.

 Tomi


--=-SbNWpPWqhfUoX2ZpWIu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYYAQAAoJEPo9qoy8lh71kdwP/3jEFGD/0Z+jeXPTT+TcPyj2
nnOm8kHoSZrZFNI02KqM3zimqNNIvdZkRbfvlq2KdUOqlqLmMrshndVUYZVqYsHm
YZL8vwBpaYfvdDom2a7ur6La8dw6lX7JwMp1uMfdpRTVbo76ksZm9BQWB76af52C
Vu1+JLRzH/N3/Kwa3WSIWSxPZebm3ttlwzhJwWi7ptAqFCUzq1qXa3j8LWU+sJbk
1Ir1N4zCERWxmNuosFChLrSULe5I9QRLOhq4JNffYCQxPNbQztKOrOCNJZytGXpT
+TyCdHzRVSOsPmmu7+6KvRdwm+OO7IC3/3xgOFGbOWPBF42+Ujz59OUyA7LFUQsz
m+tWEJPKbdrzAMAD27+fggc35m8N17qSbCuL342kgN1s5vArMBknANkd8sfZ5Z6E
CSacLMVjO+kg5o0qgfjWGMmCI3wcPtIauPJGGfg66dGOcUMYfJJ4O2K+Cx9yq+j+
aYimX6tfDqL/f/vlqE5dK/JrafRDw41k21Vv6qCcbIkz/TNg7YmMV4QSaKRawBKP
R3t3/NJ31fb36AAYYBBj/hqKogGvz4ESZ0iQqpkPevXEiOqqnzsYvrFfAndBvPO+
BQ9Oq53QNMoRWJ1DNkALQD2LaYVhSRXfPg2+VxTUusZGQhbSABZmbUrqfbcS7Sea
k9lWN1Di8Qggucll5Kwi
=LO1B
-----END PGP SIGNATURE-----

--=-SbNWpPWqhfUoX2ZpWIu3--

