From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/6] leds: lp5521: move to drivers/leds
Date: Fri, 13 Feb 2009 12:49:00 -0800
Message-ID: <200902131249.00592.david-b@pacbell.net>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com> <1234529032-25354-5-git-send-email-felipe.balbi@nokia.com> <1234529032-25354-6-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:35676 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753233AbZBMUtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 15:49:04 -0500
In-Reply-To: <1234529032-25354-6-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Friday 13 February 2009, Felipe Balbi wrote:
> +=A0=A0=A0=A0=A0=A0=A0if (!strncmp(buf, "run", 3))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip, L=
P5521_MODE_RUN);
> +=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(buf, "load", 4))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip, L=
P5521_MODE_LOAD);
> +=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(buf, "direct", 6))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip, L=
P5521_MODE_DIRECT_CONTROL);

Minor nit, which could be addressed by a followon patch:
This is an ideal use-case for using sysfs_streq().

And there's no terminal "else len =3D -EINVAL" to handle the
case of illegal modes...

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
