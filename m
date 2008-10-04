From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] Fix sections for omap-mcbsp platform driver
Date: Sat, 4 Oct 2008 15:33:08 +0100
Message-ID: <20081004143308.GA16636@flint.arm.linux.org.uk>
References: <1222262955-13599-1-git-send-email-tony@atomide.com> <1222262955-13599-2-git-send-email-tony@atomide.com> <20080924134736.GR5222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48930 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbYJDOdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Oct 2008 10:33:24 -0400
Content-Disposition: inline
In-Reply-To: <20080924134736.GR5222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>

On Wed, Sep 24, 2008 at 04:47:36PM +0300, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [080924 16:29]:
> > From: Uwe Kleine-K=F6nig <ukleinek@strlen.de>
> >=20
> > 	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/unbind
> > 	echo -n omap-mcbsp.1 > /sys/bus/platform/driver/omap-mcbsp/bind
> >=20
> > While at it move the remove function to the .devexit.text section.
>=20
> Looks like I managed to trash the subject on this one, here's a fixed
> version.

Ok.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
