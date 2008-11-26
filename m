From: David Brownell <david-b@pacbell.net>
Subject: Re: PWM drivers for TWL4030
Date: Wed, 26 Nov 2008 09:44:09 -0800
Message-ID: <200811260944.10217.david-b@pacbell.net>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <200811251742.21868.david-b@pacbell.net> <6ed0b2680811260147vf338d8av9906157a6c15b456@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:27868 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751334AbYKZRoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 12:44:16 -0500
In-Reply-To: <6ed0b2680811260147vf338d8av9906157a6c15b456@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wednesday 26 November 2008, Grazvydas Ignotas wrote:
> >
> > Might have been better to use LEDA and LEDB for backlights,
> > you probably could have saved some external hardware ... those
> > pins are high drive. =A0:)
>
> LEDB probably wasn't used for LCD backlight because it doesn't provid=
e
> enough power (60mA only). Don't know for sure, it wasn't me who
> designed the hardware.

LEDA, at 160 mA, is the one to use to use for that then.
LEDB, at 60 mA, is indeed less hefty.

Though I suppose if both backlights are high current, you'd
end up hurting anyway.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
