From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/8] i2c: lp5521: move to LED framework
Date: Thu, 12 Feb 2009 14:18:17 -0800
Message-ID: <200902121418.17837.david-b@pacbell.net>
References: <1234268165-23573-1-git-send-email-felipe.balbi@nokia.com> <1234268165-23573-4-git-send-email-felipe.balbi@nokia.com> <1234268165-23573-5-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:20100 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761405AbZBLWSV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Feb 2009 17:18:21 -0500
In-Reply-To: <1234268165-23573-5-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 10 February 2009, Felipe Balbi wrote:
> +=A0=A0=A0=A0=A0=A0=A0chip->ledr.name =3D "lp5521:red";

Rule of thumb: assume there can always be multiple instances
of a device.  In this case that's trivially possible

Exception to that rule:  rare, based on system-wide concerns.
Like there being only one PMIC, one OTG port, and so on.  In
this case, not applicable.


I'd suggest allocating some memory in the per-lp5521 struct
to hold the strings, and catenating them with a label provided
in the platform data.   That way you won't be assuming there's
only a single lp5521, and the names for the LEDs can be more
relevant to the board ... "n810::red" and so forth.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
