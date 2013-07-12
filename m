From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device
 tree based booting"
Date: Fri, 12 Jul 2013 02:46:31 -0700
Message-ID: <20130712094631.GI7656@atomide.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
 <1373539986-27272-2-git-send-email-rnayak@ti.com>
 <20130712072051.GA7656@atomide.com>
 <51DFB0E4.6040007@ti.com>
 <20130712080305.GD7656@atomide.com>
 <51DFC58C.7030105@ti.com>
 <20130712091827.GH7656@atomide.com>
 <51DFCAF3.7040503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34509 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757350Ab3GLJqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 05:46:37 -0400
Content-Disposition: inline
In-Reply-To: <51DFCAF3.7040503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

* Rajendra Nayak <rnayak@ti.com> [130712 02:29]:
>
> Right, that seems much cleaner. I will send a patch out for it and get rid
> of all the cmdline parsing in serial.c

Oh that's right, then it should not be needed for legacy pdata based
booting either :)

Regards,

Tony
