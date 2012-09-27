From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH_v2] watchdog: Convert twl4030_wdt to watchdog core
Date: Thu, 27 Sep 2012 23:23:12 +0200
Message-ID: <20120927212312.GJ16482@spo001.leaseweb.com>
References: <20120910215946.GB26184@blackmetal.musicnaut.iki.fi> <1347343270-16881-1-git-send-email-jarkko.nikula@jollamobile.com> <50643D2A.7020402@jollamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:49586 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754899Ab2I0VXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 17:23:15 -0400
Content-Disposition: inline
In-Reply-To: <50643D2A.7020402@jollamobile.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@jollamobile.com>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>

Hi,

> On 09/11/2012 09:01 AM, Jarkko Nikula wrote:
> >Convert the twl4030_wdt watchdog driver to watchdog core.
> >
> >While at there use devm_kzalloc and set the default timeout in order to be
> >able test this driver with a simple shell script.
> >
> >Signed-off-by: Jarkko Nikula<jarkko.nikula@jollamobile.com>
> >Tested-by: Aaro Koskinen<aaro.koskinen@iki.fi>

on my todo list.

Kind regards,
Wim.

