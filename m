From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE
 support
Date: Wed, 11 Apr 2012 16:17:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111615140.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36568 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933457Ab2DKWR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 18:17:26 -0400
In-Reply-To: <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs only support PWRDM_POWER_ON
> and PWRDM_POWER_INACTIVE power states. This causes
> an issue in some areas of the OMAP3 power-related
> code because of assumptions that PWRDM_POWER_RET
> and/or PWRDM_POWER_OFF are always valid states.
> 
> To get am35x SoCs to work properly, add missing support
> for PWRDM_POWER_INACTIVE and remove assumptions that
> PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Same comments here as on "arm: omap3: am35x: Set proper powerdomain 
states" -- does it even make sense for us to separate out INACTIVE at all 
in this case?  Seems like AM3517/3505 supports powerdomains ON, and that's 
it.  Seems like we can't program INACTIVE to the POWERSTATE bits, nor can 
we read it from those bits?


- Paul
