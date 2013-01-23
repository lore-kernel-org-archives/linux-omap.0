From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/6] i2c: deferred STP
Date: Wed, 23 Jan 2013 12:23:02 +0200
Message-ID: <1358936588-16375-1-git-send-email-balbi@ti.com>
References: <20130123095813.GG3767@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41326 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab3AWKXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 05:23:37 -0500
In-Reply-To: <20130123095813.GG3767@nekote.pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, Felipe Balbi <balbi@ti.com>

Hi folks,

it's now rebased on today's i2c-embedded/for-next. I boot tested with my
Blaze board.

Aaro, if you could verify it doesn't break N900, I'd be glad.

cheers

Felipe Balbi (6):
  i2c: omap: no need to access platform_device
  i2c: omap: also complete() when stat becomes zero
  i2c: omap: improve 'rev' a little bit
  i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but write to
    IRQSTATUS
  i2c: omap: wait for transfer completion before sending STP bit
  i2c: omap: get rid of b_hw flag

 drivers/i2c/busses/i2c-omap.c | 184 +++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 91 deletions(-)

-- 
1.8.1.rc1.5.g7e0651a

