From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 20/28] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Tue, 21 Jun 2011 07:49:59 -0700
Message-ID: <87vcvzz1bc.fsf@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	<1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48667 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922Ab1FUOuD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jun 2011 10:50:03 -0400
In-Reply-To: <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Thu, 9 Jun 2011 16:56:42 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> Use PM runtime and HWMOD support to handle enabling and disabling of DSS
> modules.
>
> Each DSS module will have get and put functions which can be used to
> enable and disable that module. The functions use pm_runtime and hwmod
> opt-clocks to enable the hardware.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Runtime PM usage is much better on this version, thanks!

Like Paul, I'm not crazy about the helper functions, especially the ones
that don't do much other than call runtime PM with some debug code
around them since runtime PM already has useful debug.

However, you're the maintainer and the one who has to debug this code
more than I do, so that decision is up to you.

Acked-by: Kevin Hilman <khilman@ti.com>

Kevin
