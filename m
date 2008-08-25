From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: RFC: OMAP3 SYS_OFF_MODE support
Date: Mon, 25 Aug 2008 13:27:46 +0300
Message-ID: <1219660066.1876.81.camel@kj-ubuntu>
References: <1216657043-5941-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60895 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbYHYKYx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 06:24:53 -0400
In-Reply-To: <1216657043-5941-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, ext Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

On ma, 2008-07-21 at 19:17 +0300, ext Peter 'p2' De Schrijver wrote:
> The following patch set introduces support for the OMAP3 SYS_OFF_MODE
> signal. This will cause a properly programmed triton2 to shutdown the
> VDD1 and VDD2 regulators when both core and MPU powerdomain are in off
> state. The patches includes programming triton2 with the appropriate
> scripts for the SDP3430 board.

Re-sending the patch that loads the scripts to triton2. It is a enabler
patch for future off-mode implementation.


> By default the OMAP3 polarity of the SYS_OFF_MODE signal is inverted
> compared to what triton2 expects. This means the polarity needs to be
> changed before the triton2 scripts are activated, otherwise the system
> will crash. At the moment this is done in omap2_clk_init as this
> function is called before triton2 is initialized. Better suggestions are
> welcome.

The polarity fix has been pushed already, so pushing the script loading
patch is safe now.


regards,
Kalle

> Thanks to Kalle Jokiniemi for doing the initial patch and test work.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
