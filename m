From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 0/4] ARM: OMAP2+: am33xx: Add clocktree and hwmod data
Date: Tue, 5 Jun 2012 08:31:58 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA4168D@DBDE01.ent.ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
 <20120605075952.GJ12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60382 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344Ab2FEIcF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 04:32:05 -0400
In-Reply-To: <20120605075952.GJ12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 05, 2012 at 13:29:52, Tony Lindgren wrote:
> * Vaibhav Hiremath <hvaibhav@ti.com> [120529 03:01]:
> > This patch adds complete clockctree and hwmod data for the
> > AM33XX family of devices.
> > 
> > This patch-series is cleaned up further from Paul's cleanup
> > activity on AM33xx clocktree, where all leaf nodes have been
> > removed and now modules enable/disable is controlled only
> > using hwmod framework interface.
> > 
> > There are certain modules, like clkdiv32k, debugss, etc..., for
> > which we still doesn't have hwmod_data present, so in order to
> > disable these modules during boot time, we still have to maintain
> > clk node for them. Comment has been added to highlight this, and
> > in the future we will cleanup this.
> > As far as, CLKDIV32K module, in reality is not module but still
> > we have MODULEMODE to control it, so we may have to keep this node
> > alone in the clocktree.
> 
> Considering that we have the RFC patches available for common
> clk fwk, we should probably avoid the extra churn and have this
> use the common clk fwk instead. Of course that is assuming the
> common clk fwk patches will be mergeable soonish.
> 

I will try to make sure that, their effort is only required for review 
(nothing else).

Lets here from Paul and Rajendra on this.

It would be really great if we decide to merge them to linux next, People 
really can start using linux-next/master for further development on 
BeagleBone.

Thanks,
Vaibhav

