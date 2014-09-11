From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
Date: Thu, 11 Sep 2014 21:52:45 +0200
Message-ID: <20140911195245.GP3755@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911173943.GB18849@atomide.com>
 <20140911190136.GM3755@pengutronix.de>
 <20140911191449.GF18849@atomide.com>
 <20140911194215.GO3755@pengutronix.de>
 <20140911194716.GG18849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50132 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbaIKTw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 15:52:56 -0400
Content-Disposition: inline
In-Reply-To: <20140911194716.GG18849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Tony,

On Thu, Sep 11, 2014 at 12:47:17PM -0700, Tony Lindgren wrote:
> OK great thanks. I'll apply both into omap-for-v3.18/fixes-not-urgent=
=2E
I would have put "make of_device_ids const" into cleanups, but that's u=
p
to you.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
