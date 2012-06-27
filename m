From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/2] arm: omap3: am35x: Convert emac to hwmod & disable
 hlt when open
Date: Wed, 27 Jun 2012 15:58:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271556490.27496@utopia.booyaka.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48391 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab2F0V6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 17:58:53 -0400
In-Reply-To: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

On Tue, 15 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> These patches convert the davinci emac support for the am35x SoC
> to use hwmod and add enable_hlt()/disable_hlt() calls to the
> pm_runtime hooks for that driver.
> 
> I have converted the davinci_emac driver to use pm_runtime but I
> can't formally submit it yet since it requires some changes on the
> mach-davinci side that haven't happened yet.  I will send it as an
> RFC in a reply to this thread.
> 
> The patches are based on:
>         git://git.pwsan.com/linux-2.6 am35xx_hwmod_data_fixes_a_3.5
> 
> Changes from v1:
> - patch 1/2, "arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod support"
>   is unchanged
> - patch 2/2, "arm: "omap3: am35x: Disable hlt when using Davinci EMAC"
>   has been reworked to keep the code as simple as possible per
>   http://www.spinics.net/lists/linux-omap/msg70354.html

The updated patches that were just reposted today have been queued for 
3.6, along with a few comments about the IPSS issue, mentioned earlier. 
They can be found in the branch am35xx_emac_mdio_devel_3.6 in 
git://git.pwsan.com/linux-2.6.  Please let me know if you have any 
comments.


- Paul
