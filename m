From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] [OMAP] Cleanup Beagleboard DVI reset gpio
Date: Tue, 08 May 2012 15:13:29 -0700
Message-ID: <87zk9ijp86.fsf@ti.com>
References: <4FA8DC48.5020901@compulab.co.il>
	<1336502593-32226-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48592 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752438Ab2EHWNS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 18:13:18 -0400
Received: by dano14 with SMTP id o14so1715502dan.39
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 15:13:12 -0700 (PDT)
In-Reply-To: <1336502593-32226-1-git-send-email-Russ.Dill@ti.com> (Russ Dill's
	message of "Tue, 8 May 2012 11:43:13 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, chase.maupin@ti.com, Igor Grinberg <grinberg@compulab.co.il>

Hi Russ,

Russ Dill <Russ.Dill@ti.com> writes:

> This removes several boot warnings from board-omap3beagle.c:
>
>  - gpio_request: gpio--22 (DVI reset) status -22
>  - Unable to get DVI reset GPIO

Thanks for your patches and revies on the list!  It's much appreciated.

Some requests for upstream-bound OMAP patches:

1) subject/shortlog prefix should be ARM: OMAP: [subsystem]: ...
   e.g. for this one ARM: OMAP: Beagleboard: cleanup DVI reset GPIO

2) please Cc: linux-arm-kernel@lists.infradead.org as well
 
Thanks,

Kevin
