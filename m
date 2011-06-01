From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH] OMAP: clockdomain: Remove redundant call to
 pwrdm_wait_transition()
Date: Wed, 1 Jun 2011 12:48:51 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703718FBAF9@dbde02.ent.ti.com>
References: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60913 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab1FAHTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 03:19:03 -0400
In-Reply-To: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Thursday, May 26, 2011 4:08 PM, Bedia, Vaibhav wrote:
> The call to pwrdm_wait_transition() in clkdm_clk_enable() is
> redundant since the function pwrdm_clkdm_state_switch() which
> is called next also does the same thing.  
> 

Any comments on this patch? Can it be merged?

Regards,
Vaibhav