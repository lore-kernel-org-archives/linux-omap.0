From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 2/2] arm: omap3: am35x: Disable hlt when using Davinci EMAC
Date: Thu, 31 May 2012 11:58:43 -0700
Message-ID: <871um018kc.fsf@ti.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
	<1337105642-22711-3-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60105 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756945Ab2EaS6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 14:58:44 -0400
Received: by dajt11 with SMTP id t11so1891815daj.24
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 11:58:43 -0700 (PDT)
In-Reply-To: <1337105642-22711-3-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Tue, 15 May 2012 11:14:02 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> The am35x family of SoCs has a Davinci EMAC ethernet
> controller on-chip.  Unfortunately, the EMAC is unable
> to wake the PRCM when there is network activity which
> leads to a hung or extremely slow system when the MPU
> has executed a 'wfi' instruction (because of pm_idle
> or CPUidle).  To prevent this, add hooks to the EMAC
> pm_runtime suspend/resume calls so that hlt is disabled
> whenever the EMAC is in use.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Looks good,

Acked-by: Kevin Hilman <khilman@ti.com>

