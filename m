From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 3/7] omap3: voltage: fix channel configuration
Date: Mon, 5 Dec 2011 11:35:36 +0200
Message-ID: <1323077736.7555.10.camel@sokoban>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
	 <1322492005-27741-4-git-send-email-t-kristo@ti.com> <87pqg6jzq6.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49679 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721Ab1LEJgZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Dec 2011 04:36:25 -0500
In-Reply-To: <87pqg6jzq6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

On Fri, 2011-12-02 at 15:55 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
> > overlap with VDD2 and attempting to modify VDD1 voltage will actually change
> > VDD2 voltage.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> I've forgotten a bit how this was supposed to work (again), Can you
> elaborate more on how this fails?

There is a diagram in the OMAP TRM for setting the bits in this
register, however the racen fix part appears to be needed only for
omap4. I can drop this part of the fix from the series if you want for
the next version, alternatively I can split this patch into two.

The idea for this part of the fix is anyway that the channel
configuration is more complex in omap4, we define volt_reg and cmd_reg
addresses for each omap4_X_pmic, however we only want to enable racen
bit only if cmd and volt register addresses are the same. Otherwise the
voltage commands are not sent (or are sent to invalid address) which
causes the voltage commands not to change voltages at all.

-Tero

> Setting the OMAP_VC_CHANNEL_DEFAULT flag makes sense to me, but the
> other change doesn't.
> 
> Kevin


