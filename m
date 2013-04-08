From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/3] omap timer changes for v3.10 merge window
Date: Mon, 8 Apr 2013 19:36:56 +0200
Message-ID: <201304081936.56288.arnd@arndb.de>
References: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53806 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3DHRhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:37:04 -0400
In-Reply-To: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 04 April 2013, Tony Lindgren wrote:
> Clean-up for omap2+ timers from Jon Hunter <jon-hunter@ti.com>:
> 
> This series consists mainly of clean-ups for clockevents and
> clocksource timers on OMAP2+ devices. The most significant change
> in functionality comes from the 5th patch which is changing the
> selection of the clocksource timer for OMAP3 and AM335x devices
> when gptimers are used for clocksource.
> 
> Note that this series depends on 7185684 (ARM: OMAP: use
> consistent error checking) in RMK's tree and 960cba6 (ARM:
> OMAP5: timer: Update the clocksource name as per clock data)
> in omap-for-v3.10/fixes-non-critical. So this branch is based
> on a merge of 7185684 and omap-for-v3.10/fixes-non-critical
> to avoid non-trivial merge conflicts.
> 

Pulled into next/drivers, thanks!

Do you have a URL for a stable branch containing 7185684
that we can list in our branch description file?

	Arnd
