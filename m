From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 12/23] move twl4030-gpio to drivers/gpio
Date: Mon, 29 Sep 2008 13:06:19 -0700
Message-ID: <200809291306.20349.david-b@pacbell.net>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <1222707783-18936-12-git-send-email-me@felipebalbi.com> <1222707783-18936-13-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:21084 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751939AbYI2UGX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 16:06:23 -0400
In-Reply-To: <1222707783-18936-13-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Monday 29 September 2008, Felipe Balbi wrote:
> =A0drivers/{i2c/chips =3D> gpio}/twl4030-gpio.c | =A0 37 ++++++++++++=
+++++++++++----

Best to avoid sending this type of patch except as backup
to a git pull request ... it's unusable to folk who use
quilt and thus don't have access to GIT extensions.

Where "unusable" means "can't apply the patch".

- dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
