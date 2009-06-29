From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF, reduces OFF latency by 20ms
Date: Mon, 29 Jun 2009 11:58:21 -0700
Message-ID: <8763ee98aa.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305A54205@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:34690 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbZF2S6j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 14:58:39 -0400
Received: by pzk26 with SMTP id 26so392908pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 11:58:43 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305A54205@dbde02.ent.ti.com> (Rajendra Nayak's message of "Wed\, 17 Jun 2009 18\:31\:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>  
>
>>-----Original Message-----
>>From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com] 
>>Sent: Wednesday, June 17, 2009 6:18 PM
>>To: Nayak, Rajendra
>>Cc: linux-omap@vger.kernel.org; Derrick, David; Woodruff, Richard
>>Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle 
>>before OFF, reduces OFF latency by 20ms
>>
>>On Wed, 2009-06-17 at 15:38 +0300, Nayak, Rajendra wrote:
>>> 
>>> >-----Original Message-----
>>> >From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com] 
>>> >Sent: Wednesday, June 17, 2009 3:56 PM
>>> >To: Nayak, Rajendra
>>> >Cc: linux-omap@vger.kernel.org; Derrick, David; Woodruff, Richard
>>> >Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle 
>>> >before OFF, reduces OFF latency by 20ms
>>> >
>>> >On Wed, 2009-06-17 at 12:50 +0300, Nayak, Rajendra wrote:
>>> >> >-----Original Message-----
>>> >> >From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com] 
>>> >> >Sent: Wednesday, June 17, 2009 1:17 PM
>>> >> >To: Nayak, Rajendra
>>> >> >Cc: linux-omap@vger.kernel.org; Derrick, David; Woodruff, Richard
>>> >> >Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle 
>>> >> >before OFF, reduces OFF latency by 20ms
>>> >> >
>>> >> >Hi Rajendra,
>>> >> >
>>> >> >On Tue, 2009-06-16 at 14:52 +0300, Rajendra Nayak wrote:
>>> >> >> If autoidle for DPLL4 is enabled in the stored scratchpad
>>> >> >> value of CM_AUTOIDLE_PLL then there is an added delay by
>>> >> >> the boot ROM when coming out of OFF mode.
>>> >> >> The patch disables this bitfield in the stored 
>>scratchpad value.
>>> >> >> 
>>> >> >> This should significantly reduce CORE OFF latency and also
>>> >> >> bring down the threshold for CORE OFF, making OFF affordable
>>> >> >> even with smaller sleep times.
>>> >> >
>>> >> >I did some measurements on RX-51 with this patch, and it 
>>> >seems it does
>>> >> >not reduce latency, it increases it by few hundred us.
>>> >> >
>>> >> >Servicing an empty timer interrupt from off mode 
>>(measured from VDD1
>>> >> >ramp up to start of VDD1 ramp down):
>>> >> >
>>> >> >with dpll4 patch : ~14100us
>>> >> >without patch    : ~13600us
>>> >> >
>>> >> >I attached pictures of both situations.
>>> >> >
>>> >> >My kernel had only C7 state enabled.
>>> >> >
>>> >> >Have you measured the latency effects on SDP or some other board?
>>> >> 
>>> >> I haven't done the latency measurements on SDP yet, but 
>>> >David had done it
>>> >> sometime back, using a different codebase though.
>>> >
>>> >OK, I also used our internal code base. Though the PM 
>>functionality is
>>> >pretty much the same as in l-o:pm branch.
>>> >
>>> >> 
>>> >> Can you explain more on how you are measuring the latency 
>>> >here, I am a bit
>>> >> confused. This is supposed to bring down the OFF wakeup 
>>> >latency, the sleep latency
>>> >> remains the same.
>>> >
>>> >I'm doing a timer interrupt periodically. Servicing that timer 
>>> >interrupt
>>> >takes the same amount of time every time. What varies (with 
>>the patch)
>>> >is the transition times from off to active and back to off.
>>> >
>>> >In the pictures the top graph shows current and bottom 
>>graph shows the
>>> >VDD1 and VDD2 voltages. I zoomed from the pictures the interval from
>>> >when VDD1 goes up, to the point when it starts to go down again.
>>> >
>>> >So I measured: wakeup latency + interrupt service + sleep latency.
>>> 
>>> Is the boot ROM different on the OMAP devices on nokia h/w or is it
>>> the same as that on the SDP?
>>
>>I have heard that our ROM version would be somehow older version, but I
>>really don't have any facts on that matter.
>
> Oh.. it turns out that when the scratchpad save routine is called, the autoidle
> for PER is not even set. Its only set some place later.
> So the 20ms or so advantage was always there on l-o pm branch even without this
> patch :)
>

So for the benefit of the archives... 

I'm dropping this patch since the equivalent is alrady in PM branch.

Kevin
