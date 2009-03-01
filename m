From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: RE: omap3 cpuidle interrupt latency
Date: Mon, 2 Mar 2009 02:19:28 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74EE7@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301CBEA0787@dbde02.ent.ti.com>,<13B9B4C6EF24D648824FF11BE8967162037B4D1787@dlee02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301CBEA0788@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301CBF74EE4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51053 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbZCAUtk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2009 15:49:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n21KnWhs029072
	for <linux-omap@vger.kernel.org>; Sun, 1 Mar 2009 14:49:38 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n21KnV5i011231
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 02:19:31 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74EE4@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "Dasgupta, Romit" <romit@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Monday, March 02, 2009 1:31 AM
> To: Dasgupta, Romit; Woodruff, Richard; linux-omap@vger.kernel.org
> Subject: RE: omap3 cpuidle interrupt latency
> 
> > -----Original Message-----
> > From: Dasgupta, Romit
> > Sent: Sunday, March 01, 2009 12:18 PM
> > To: Woodruff, Richard; Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: RE: omap3 cpuidle interrupt latency
> >
> > It would be nice if this device could dynamically set
> > constraints (say by using a short kernel timer during
> > activity or set/remove pm_qos latency) or the prediction
> > aspect of cpuidle could be improved using rules feed from
> > things like interrupt source.
> 
> Despite all constraints; the latency concern is still valid.
> 
> The constraints would either prevent idle state transition;
> or in the idle processing we could still have repeat of current
> situation - though less often.
> 
> I feel checking for pending interrupt before executing WFI
> would help. Will try in the morning.

Moving time keeping functions out of interrupt disabled context may also help. Something like this

return_sleep_time:
        local_irq_enable();
        local_fiq_enable();
        getnstimeofday(&ts_postidle);
        ts_idle = timespec_sub(ts_postidle, ts_preidle);

ARM will wakeup from WFI idle on nIRQ/nFIQ signal assertion. But interrupts will be processed only after they are enabled in CPSR AFAIK.

Regards,
Pratheesh

