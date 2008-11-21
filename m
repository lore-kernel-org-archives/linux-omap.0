From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: Re: [PATCH 5/9] OMAP: HSMMC: Fix oops in omap_mmc_remove
Date: Fri, 21 Nov 2008 17:27:17 +0200
Message-ID: <20081121152717.GA13908@angel.research.nokia.com>
References: <49267E28.1020303@nokia.com> <49268161.1010304@nokia.com> <4926859F.8090902@nokia.com> <4926865A.7070406@nokia.com> <6ed0b2680811210603s17f7a43fw4dd0d57bc5dd829c@mail.gmail.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53144 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112AbYKUP1u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 10:27:50 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680811210603s17f7a43fw4dd0d57bc5dd829c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, Nov 21, 2008 at 04:03:25PM +0200, ext Grazvydas Ignotas wrote:
...
> Also, HCTL SDVSDET bit will never be set for MMC2 and MMC3, causing
> mentioned omap_mmc_switch_opcond() to be called unconditionally here.
> 
> The same block can be found in mmc_omap_detect() function, where it is
> executed on card removal. There it causes MMC2 controller to stop
> working completely on pandora board :(

TI TRM saus HSMMC2 and HSMMC3 works only with SDVS set to 1.8V in HCTL.

If the voltage is set to 3.0V and then SDBP (bus power bit) is set,
it is rejected and SDBP remains zero, the controller does nothing and 
is seemingly frozen.

The wrong voltage for MMC2 SDVS is set in omap_mmc_switch_opcond() if 
vdd different from 1.8V.

Also omap_mmc_suspend() set SDVS to 3.0V even for MMC2 and MMC3.  When
suspending, everything seemed to work and at resume MMC2 was hung
and failed to detect the card since not even CMD0 was sent.

Regards
Jarkko Lavinen
