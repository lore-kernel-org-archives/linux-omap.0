From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: RX-51: add explicit mux configuration of
 tsc2005 control gpios
Date: Mon, 5 Mar 2012 10:07:53 -0800
Message-ID: <20120305180753.GB12083@atomide.com>
References: <1323894845-29368-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16476 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133Ab2CESHz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 13:07:55 -0500
Content-Disposition: inline
In-Reply-To: <1323894845-29368-1-git-send-email-vz@mleia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>

* Vladimir Zapolskiy <vz@mleia.com> [111214 12:02]:
> This change converts TSC2005 related GPIO requests to be done with
> gpio_request_array() method and explicitly inits mux configuration for
> these GPIOs.

Thanks applying into board branch.

Regards,

Tony
