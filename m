From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
Date: Tue, 6 Nov 2012 09:38:04 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04897@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
 <50950AC7.1030707@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
 <50982DB2.4000104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37138 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2KFJiS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 04:38:18 -0500
In-Reply-To: <50982DB2.4000104@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Jon,

On Tue, Nov 06, 2012 at 02:50:50, Hunter, Jon wrote:
[...]
> 
> Why is this? How is the dmtimer TIOCP_CFG register configured on AM33xx?
> Is it using smart-idle?
> 

Yes, it is set to smart-idle with wakeup capable mode. (this needs a fixup
since this timer is not wakeup capable) but unfortunately this is not
sufficient. On AM33xx there's no HW_AUTO mode magic so unless the IPs in
PER domain are disabled by s/w, PER domain can't transition.

> > The next one is that
> > the clockevent doesn't generate any further interrupts once the
> > system resumes. We need to restore the pre-suspend configuration.
> > I haven't tried but I guess we could have used the save and restore
> > of timer registers here.
> 
> It would be interesting to try using an non-wakeup domain timer on
> OMAP3/4 for clock events and seeing if suspend/resume works.
>
> Do you know what the exact problem here is? I understand that the timer
> context could get lost, but exactly what is not getting restarted by the
> kernel? For example, the only place we set the interrupt enable is
> during the clock event init and so if the context is lost, then I could
> see no more interrupts occurring. So is it enough to just restore the
> interrupt enable register, do you really need to program the timer again?
> 

Just restoring the interrupt enable register works. But since there's no logic
retention I think a context save-restore would be better.

Regards,
Vaibhav
