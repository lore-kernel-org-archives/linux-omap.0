From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc8-omap] twl4030 power scripts, initsection fixups
Date: Sat, 14 Mar 2009 12:00:53 -0700
Message-ID: <200903141200.53768.david-b@pacbell.net>
References: <200903131825.52114.david-b@pacbell.net> <20090314105659.GA8832@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:25676 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752238AbZCNTA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 15:00:56 -0400
In-Reply-To: <20090314105659.GA8832@gandalf>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: OMAP <linux-omap@vger.kernel.org>

On Saturday 14 March 2009, Felipe Balbi wrote:
> >=20
> > Remove section mismatch warnings from twl4030 power script
> > declaration ... unfortunately, this use-once data can't live
> > in initdata sections (or initconst) until some driver stacks
> > (starting with I2C) have better support for non-hotpluggable
> > componentry.
>=20
> should you update this with the following ?

I didn't see any section mismatch warnings from this goofage.  ;)

But, yes this looks wrong too.  Resend with your s-o-b ...


> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -66,7 +66,7 @@ static u8 triton_next_free_address =3D 0x2b;
> =A0#define KEY_1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
0xC0
> =A0#define KEY_2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
0x0C
> =A0
> -static int __init twl4030_write_script_byte(u8 address, u8 byte)
> +static int twl4030_write_script_byte(u8 address, u8 byte)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0int err;
>=20
> 	... deleted similar changes ...


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
