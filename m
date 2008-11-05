From: David Brownell <david-b@pacbell.net>
Subject: Re: [REVIEW  PATCH 8/9] DSS: support for Beagle Board
Date: Wed, 5 Nov 2008 15:21:48 -0800
Message-ID: <200811051521.48924.david-b@pacbell.net>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu> <20081105122725.cb1c0b2f.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:36087 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752542AbYKEXVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 18:21:51 -0500
In-Reply-To: <20081105122725.cb1c0b2f.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Wednesday 05 November 2008, Jarkko Nikula wrote:
> > +=A0=A0=A0=A0=A0r =3D gpio_request(beagle_display_data_dvi.panel_re=
set_gpio, "DVI reset GPIO");
> > +=A0=A0=A0=A0=A0if(r < 0) {
>=20
> GPIO label "DVI reset" is enough.

Surely this ** doesn't work ** at least against the OMAP git tree
which already has:

        omap_cfg_reg(J25_34XX_GPIO170);
        gpio_request(170, "DVI_nPD");
        /* REVISIT leave DVI powered down until it's needed ... */
        gpio_direction_output(170, true);

Label matches the DVI chip, not board schematics.  Agreed,
it's not a reset.

I'd like to see any FB/DSS/... updates have the property that
the TFP410 chip is powered down *unless* both (a) the frame
buffer/DSS/... driver is active, and (b) the DVI channel is
in use.

So for example a kernel without FB/DSS/... configured, that
DVI chip is never powered up.  And when only the S-Video channel
is used, DVI isn't powered up either.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
