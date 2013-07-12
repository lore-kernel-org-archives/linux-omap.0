From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Fix omap serial early crash during hwmod _setup()
Date: Fri, 12 Jul 2013 00:22:45 -0700
Message-ID: <20130712072244.GB7656@atomide.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29692 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757132Ab3GLHWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 03:22:50 -0400
Content-Disposition: inline
In-Reply-To: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

* Rajendra Nayak <rnayak@ti.com> [130711 03:59]:
> This series should fix the issue with the early serial crash seen
> during hwmod _setup() as reported by [1]
> 
> The issue was reported on a am33xx device and was not seen on omap4
> or omap5 devices as the hwmod data for both omap4 and omap5 had
> statically defined HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET for
> uart3 which happens to be the debug console used on omap4 panda and
> omap5 uevm boards.

The serial driver should be capable of setting this on it's own
as it sets up the console.

Regards,

Tony
