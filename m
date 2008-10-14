From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 5/8] leds: lp5521: register separate leds
Date: Tue, 14 Oct 2008 20:09:32 +0300
Message-ID: <20081014170931.GH20247@frodo>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-5-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com> <200810140855.21657.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44872 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbYJNRJm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 13:09:42 -0400
Content-Disposition: inline
In-Reply-To: <200810140855.21657.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Tue, Oct 14, 2008 at 08:55:21AM -0700, David Brownell wrote:
> On Tuesday 14 October 2008, Felipe Balbi wrote:
> > @@ -23,7 +24,9 @@
> > =A0#include <linux/module.h>
> > =A0#include <linux/init.h>
> > =A0#include <linux/i2c.h>
> > +#include <linux/leds.h>
> > =A0#include <linux/mutex.h>
> > +#include <linux/workqueue.h>
> > =A0
> > =A0#define LP5521_DRIVER_NAME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
"lp5521"
> > =A0
>=20
> Ah, *here* it converts to use the LED framework.  The patch
> comment should probably focus on that ... "separate leds" is
> just an artifact of that conversion, as I interpret things.

Sure, I'll update and resend tomorrow. The ambient light sensor, I'll
drop from now and leave it pending until we have a good answer for wher=
e
it should go.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
