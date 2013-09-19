From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] RX-51: Add missing max_current to
 rx51_lp5523_led_config
Date: Thu, 19 Sep 2013 14:29:22 -0700
Message-ID: <20130919212922.GA27501@atomide.com>
References: <1379541145-25934-1-git-send-email-pali.rohar@gmail.com>
 <20130918222642.GK9994@atomide.com>
 <201309192301.58761@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46555 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885Ab3ISV30 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Sep 2013 17:29:26 -0400
Content-Disposition: inline
In-Reply-To: <201309192301.58761@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130919 14:10]:
> On Thursday 19 September 2013 00:26:43 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130918 15:02]:
> > > Without max_current data in board file lp5523 driver does
> > > not change current.
> >=20
> > Hmm is this a regression or are there other reasons to merge
> > this during the -rc cycle?
> >=20
>=20
> I think this is regression, drivers/leds/leds-lp55xx-common.c=20
> code refuse to change led_current sysfs attribute if value is=20
> higher than max_current specified in board file. And because in=20
> board file max_current is not specified it is by default zero as=20
> global variable. So changing led_current is not possible because=20
> any positive value is more than zero. First I saw this behaviour=20
> in 3.10, but I forgot to send this patch.

OK thanks, can you please update the patch description with
that so I can merge it for the -rc cycle? Ideally of course
with the breaking commit too.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
