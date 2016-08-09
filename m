From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Date: Tue, 9 Aug 2016 13:57:40 +0200
Message-ID: <20160809115740.GA5528@pengutronix.de>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Jochen Friedrich <jochen@scram.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>Seth Heasley <se>
List-Id: linux-omap@vger.kernel.org

Hello Wolfram,

On Tue, Aug 09, 2016 at 01:36:17PM +0200, Wolfram Sang wrote:
> The core will do this for us now.

Would be nice to point out the relevant commit that changed the core in
the commit log.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
