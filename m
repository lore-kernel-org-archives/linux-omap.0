From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 01/15] mfd: menelaus: Drop __exit section annotation
Date: Wed, 11 Dec 2013 10:48:38 +0100
Message-ID: <20131211094838.GH18888@pengutronix.de>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386606085-26838-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: lee.jones@linaro.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 09, 2013 at 10:21:11AM -0600, Felipe Balbi wrote:
> We could build that driver as a dynamically-linked module.
ups, only saw now the v3 after I commented on v2. So you addressed a
part of my comment already. Still building that driver as a module also
works without this patch, right? So this is only about hotplugging
(which usually doesn't work on i2c, so only via /sys/bus/i2c) and drive=
r
unloading.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
