From: David Brownell <david-b@pacbell.net>
Subject: Re: leds-gpio broken with current git?
Date: Thu, 15 Jan 2009 07:58:49 -0800
Message-ID: <200901150758.49601.david-b@pacbell.net>
References: <7088542D-28A0-4BCA-9583-6BCDDF9E960A@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:25847 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755091AbZAOP7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 10:59:13 -0500
In-Reply-To: <7088542D-28A0-4BCA-9583-6BCDDF9E960A@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Thursday 15 January 2009, Koen Kooi wrote:
> I've been playing with different kernels on beagleboard lately and it=
 =A0
> seems that somewhere between 2.6.28rc8 and the final release leds-gpi=
o =A0
> got broken for beagleboard:
>=20
> Registered led device: beagleboard::usr0
> Registered led device: beagleboard::usr1
> leds-gpio: probe of leds-gpio failed with error -22

Works for me, no "-EINVAL", on 2.6.28-omap1 and no patches
that should affect GPIOs or LEDs.  Last patch applied to
GIT is 15f75b6226c2d3b82062bb721e7cb9a1d6f35efd (musbhsdma).

OK, I'm just pulling a new batch of objects, I'm guessing
Tony snuck in RC1 already ... yes, I see he just sent a
post about that a few minutes ago.  ;)

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
