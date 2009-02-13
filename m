From: David Brownell <david-b@pacbell.net>
Subject: Re: Hi David Brownell. I have a question for twl4030 driver.
Date: Fri, 13 Feb 2009 12:35:55 -0800
Message-ID: <200902131235.55502.david-b@pacbell.net>
References: <90b950fc0902121906kdf51637v21b90a2aba94a93f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:20931 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751339AbZBMUf6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 15:35:58 -0500
In-Reply-To: <90b950fc0902121906kdf51637v21b90a2aba94a93f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <daeinki@gmail.com>
Cc: linux-omap@vger.kernel.org

On Thursday 12 February 2009, =EB=8C=80=EC=9D=B8=EA=B8=B0 wrote:
> I added "struct regulator_init_data xxx_vpll2" to board-xx.c file to =
use VPLL2.
> but couldn't use it because you annotated codes for VPLL2 like below.
>=20
> 	...
>=20
> So I could use VPLL2 after I get rid of those annotations.
> I wonder why did you annotate for VPLL2.
> Does using VPLL2 has some problems?

I didn't have any use case for managing VPLL2 in Linux
software at runtime, except maybe in conjunction with
the power management code.

What's your use case?

Some of the supported operating points require changes
to supplies like VDD1 and VDD2 ... I thought that if
the power management code needed to use the regulator
framework, we'd hear about it later and be able to deal
with those issues at that time.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
