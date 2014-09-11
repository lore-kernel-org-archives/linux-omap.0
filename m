From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
Date: Thu, 11 Sep 2014 13:10:39 -0700
Message-ID: <20140911201039.GH18849@atomide.com>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911173943.GB18849@atomide.com>
 <20140911190136.GM3755@pengutronix.de>
 <20140911191449.GF18849@atomide.com>
 <20140911194215.GO3755@pengutronix.de>
 <20140911194716.GG18849@atomide.com>
 <20140911195245.GP3755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11002 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbaIKUKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 16:10:45 -0400
Content-Disposition: inline
In-Reply-To: <20140911195245.GP3755@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [140911 12:53]=
:
> Hello Tony,
>=20
> On Thu, Sep 11, 2014 at 12:47:17PM -0700, Tony Lindgren wrote:
> > OK great thanks. I'll apply both into omap-for-v3.18/fixes-not-urge=
nt.
> I would have put "make of_device_ids const" into cleanups, but that's=
 up
> to you.

Yes that would have worked too but already applied and building
randconfigs :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
