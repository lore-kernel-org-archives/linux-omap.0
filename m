From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/6] OMAP: mmc-twl4030 support VSIM is VMMC2_IO
Date: Tue, 10 Mar 2009 09:46:57 -0800
Message-ID: <200903101046.58599.david-b@pacbell.net>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop> <20090310093309.16889.79381.sendpatchset@ahunter-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:28926 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754522AbZCJRrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2009 13:47:05 -0400
In-Reply-To: <20090310093309.16889.79381.sendpatchset@ahunter-laptop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tuesday 10 March 2009, Adrian Hunter wrote:
> @@ -61,6 +65,7 @@ static struct twl_mmc_controller {
> =A0=A0=A0=A0=A0=A0=A0=A0struct omap_mmc_platform_data=A0=A0=A0*mmc;
> =A0=A0=A0=A0=A0=A0=A0=A0u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0t=
wl_vmmc_dev_grp;
> =A0=A0=A0=A0=A0=A0=A0=A0u8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0t=
wl_mmc_dedicated;
> +=A0=A0=A0=A0=A0=A0=A0bool=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0vsim_18=
v;
> =A0=A0=A0=A0=A0=A0=A0=A0char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0name[=
HSMMC_NAME_LEN + 1];
> =A0} hsmmc[OMAP34XX_NR_MMC] =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0{

I have an alternate approach to your patches #2, and #6 ...
basically, as part of switching the mmc-twl4030 glue over to
the regulator framework, each MMC device can have two named
supplies.  (And the glue should work with PMICs other than
just the twl4030 family chips.)

So an eMMC chip with both power rails switchable would set up
one for Vcc, and a second for VccQ ... which need not be VSIM,
and need not even use a twl4030.  MMC2 and MMC3 would be able
to switch VccQ on after Vcc, for eMMC ... or similarly for an
SDIO chip with a switchable regulator.

So your #2 patch won't be needed, since the second supply would
be handled in a more general way; ditto #6.  Some of the other
patches will also be affected.

I'll send patches implementing this as soon as I get them
working on one more board.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
