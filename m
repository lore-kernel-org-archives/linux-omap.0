From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Add usb support to omap3beagle
Date: Thu, 17 Apr 2008 12:36:07 -0700
Message-ID: <200804171236.07509.david-b@pacbell.net>
References: <CE83D2E2-7DC8-471C-AD14-14A6FED413A9@student.utwente.nl> <200804171126.54874.david-b@pacbell.net> <7F9BB0C5-23DD-4F44-904C-EF3F70324421@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:31134 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754288AbYDQTgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 15:36:10 -0400
In-Reply-To: <7F9BB0C5-23DD-4F44-904C-EF3F70324421@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

On Thursday 17 April 2008, Koen Kooi wrote:
> >>
> >> @@ -69,6 +70,7 @@
> >> =A0=A0=A0=A0=A0omap_board_config_size =3D ARRAY_SIZE(omap3_beagle_=
config);
> >> =A0=A0=A0=A0=A0omap_serial_init();
> >> =A0=A0=A0=A0=A0sdp_mmc_init();
> >> +=A0=A0=A0=A0sdp3430_usb_init();
> >> }
> >>
> >> arch_initcall(omap3_beagle_i2c_init);
> >
> > I hope someone makes those sdp_*() routines generic ... or does
> > "SDP" not stand for "Software Development Platform" (different boar=
d)?
>=20
> Those routines are indeed name after the sdp board, but they seem
> generic enough to get reused in other boards (e.g. omap3evm or omap3
> beagle) without change :)

They aren't quite generic enough ... with those names!  :)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
