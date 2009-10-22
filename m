From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 01/17] PM: fix suspend control for IVA2
Date: Thu, 22 Oct 2009 16:21:57 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B459EE8@dlee02.ent.ti.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <alpine.DEB.2.00.0910220419550.17644@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37048 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201AbZJVVWA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 17:22:00 -0400
In-Reply-To: <alpine.DEB.2.00.0910220419550.17644@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <tero.kristo@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Ghongdemath, Girish" <girishsg@ti.com>, "hiroshi.doyu@nokia.com" <hiros>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Thursday, October 22, 2009 5:24 AM

> > IVA2 controls its target power state individually, thus suspend should not
> > touch IVA2. Without this patch DSP suspend always fails.
>
> We don't allow other device drivers to touch PRCM bits, so we should
> probably should remove all PRCM register accesses from the DSPBridge code,
> so all power control should go through the ARM.
>
> Is there a reason why the ARM code can't handle the DSP powerdomain?

Sharing with DSP is something which probably could use some improvement.

Today DSP self-manages its domain.  Its (bios) micro-kernel makes decisions to optimize its domain. The ARM can't really micro-manage the DSP as he doesn't even want to know at the detail level what the DSP is up to at every instant.

- During idle time cpuidle should just be checking dsp status to see if its current state gets in the way of a low c-state.

- bridge does register with suspend frame work so he should do the right thing when in the system.

* problem is when bridge isn't there what to do.  This is especially after an unload of the bridge.

What has been proposed in the past is like what Kevin inputted in related thread about having maintenance hand off.  But for some reason it never quite to the top of the list.

- bridge does request thought clock frame work clocks especially of those which are public peripherals.

- bridge could request everything but it was not projected as power efficient waking up the big arm core for something the dsp could do itself and has all control over.  This is especially true if you have dsp doing the rendering for something like mp3.  it gets the wake ups and streaming and only every great while wakes the arm to give it a pile more data.  Waking the arm every time it runs its equivalent of cpuidle was discourged.

- main other sharing conflict was with irq routing between arm and bridge.  Right now its kind of init mode setup.  I guess this is ok for todays usage.

...... so after context current code is not requesting through pm code purposefully.  The hardware has been evolving from omap1,2,3,4 to make for more of a distributed model.  After all the details/constraints are understood with silicon there is some time to re-evaluate if its paying back or not.

Regards,
Richard W.


