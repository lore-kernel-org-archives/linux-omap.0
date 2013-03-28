From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Thu, 28 Mar 2013 08:58:04 -0700
Message-ID: <20130328155803.GT10155@atomide.com>
References: <24838523.73311.1364448607026.JavaMail.apache@mail82.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50237 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752715Ab3C1P6K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 11:58:10 -0400
Content-Disposition: inline
In-Reply-To: <24838523.73311.1364448607026.JavaMail.apache@mail82.abv.bg>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: pali.rohar@gmail.com, nm@ti.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=
=80=D0=BE=D0=B2 <freemangordon@abv.bg> [130327 22:34]:
>  Tony,
>=20
> Who do you expect to make that code merge? Do you expect us to mechan=
ically merge RX51 PPA API patch with the existing generic OMAP PPA API =
code putting #ifdefs all over the place? Not that it is impossible, but=
 the only real piece of HW I have here is n900, so I just can't be sure=
 the code will still work on the other platforms besides RX51, once the=
 code modified. Please, advice on how to proceed.

Probably ifdefs won't work nice for other omapss. It seems that
your original patch is pretty close based on all that's been
discussed. Can you please repost with a proper patch description
also summarizing why we cannot have generci SMC API as discussed?

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
