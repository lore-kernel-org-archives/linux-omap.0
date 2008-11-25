From: David Brownell <david-b@pacbell.net>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 10:46:45 -0800
Message-ID: <200811251046.45693.david-b@pacbell.net>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com> <26A46655-D823-4AE1-A058-79A769051398@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:40129 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752133AbYKYTQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 14:16:11 -0500
In-Reply-To: <26A46655-D823-4AE1-A058-79A769051398@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tuesday 25 November 2008, Koen Kooi wrote:
> Regardless of what implementation you choose, it would be *great* if =
=A0
> people used the backlight class for things like backlights. /sys/clas=
s/=20
> backlight/<foo>/brightness is such a nice standard that lots and lots=
 =A0
> of usespace tools rely on it.

How about a standard LED driver (optionally with a brightness
control) and the newish "backlight" trigger?

Of course, the packaging (led driver and trigger, vs. backlight
control) can be independent of the controls that are exported.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
