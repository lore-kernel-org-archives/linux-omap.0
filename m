From: Daniel Mack <zonque@gmail.com>
Subject: Re: [RFC PATCH 0/4] cpsw: support for control module register
Date: Mon, 09 Sep 2013 10:58:32 +0200
Message-ID: <522D8DB8.5050305@gmail.com>
References: <1378639438-27686-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:43227 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3III6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 04:58:35 -0400
In-Reply-To: <1378639438-27686-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, bcousson@baylibre.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

On 08.09.2013 13:23, Mugunthan V N wrote:
> This patch series adds the support for configuring GMII_SEL register
> of control module to select the phy mode type and also to configure
> the clock source for RMII phy mode whether to use internal clock or
> the external clock from the phy itself.
> 
> Till now CPSW works as this configuration is done in U-Boot and carried
> over to the kernel. But during suspend/resume Control module tends to
> lose its configured value for GMII_SEL register in AM33xx PG1.0, so
> if CPSW is used in RMII or RGMII mode, on resume cpsw is not working
> as GMII_SEL register lost its configuration values.
> 
> The initial version of the patch is done by Daniel Mack but as per
> Tony's comment he wants it as a seperate driver as it is done in USB
> control module. I have created a seperate driver for the same and as
> the merge window is open now and no feature request is accepted I am
> submitting it as RFC for reviews.

Thanks for doing this. It's a somehow expensive approach of writing a
single 32bit register, but I agree it's cleaner to not have this code in
the cpsw driver directly.

For the whole series:

  Tested-by: Daniel Mack <zonque@gmail.com>



Daniel

