From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 5/5] ARM: OMAP3: Update clocksource timer selection
Date: Fri, 1 Feb 2013 09:31:04 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED073AA@DBDE01.ent.ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
 <1359565471-30721-6-git-send-email-jon-hunter@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ED07250@DBDE01.ent.ti.com>
 <510B83D5.1090500@ti.com> <510B8A0B.9000600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51967 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558Ab3BAJbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 04:31:10 -0500
In-Reply-To: <510B8A0B.9000600@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 01, 2013 at 14:55:31, Hunter, Jon wrote:
[...]
> > 
> > I don't see this as being DT specific. It is more of a policy change to
> > ensure a wake-up domain timer is used for clocksource when we are using
> > gptimers for both clocksource and clockevents. It was your patch for
> > AM335x that made me see the need for this, if that makes sense. May be I
> > should have referenced that in the changelog.
> 
> Sorry to be clear, I don't see the policy change as DT specific.
> 
> In answer to your question, yes clkev_nr and clksrc_nr are changed so
> the policy it is consistent regardless of whether you use DT or not. In
> other words, an OMAP3 board using a gptimer for clocksource  (such as
> cm-t3517) and does not use DT, would work the same as AM335x with DT.
> 

Ok. Thanks for clarifying.

Regards,
Vaibhav
