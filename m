From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: OMAP4 clock/pm fixes [was: [PATCH v4 2/3] ARM: omap: hwmod: get
 rid of all omap_clk_get_by_name usage
Date: Fri, 5 Oct 2012 15:51:50 +0200
Message-ID: <506EE5F6.5020605@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com> <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com> <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com> <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com> <1346397309.18766.5.camel@lappyti> <504073CF.6010804@ti.com> <1346401643.32389.4.camel@deskari> <504075A0.7010708@ti.com> <506EAC89.2070307@ti.com> <506ED079.70700@ti.com> <506ED29E.7070403@ti.com> <506ED492.5010709@ti.com> <506EDEB3.3050003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41605 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455Ab2JENvz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 09:51:55 -0400
In-Reply-To: <506EDEB3.3050003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>

On 10/05/2012 03:20 PM, Archit Taneja wrote:
> On Friday 05 October 2012 06:07 PM, Rajendra Nayak wrote:
>> On Friday 05 October 2012 05:59 PM, Archit Taneja wrote:
>>> The other not so good option to make DSS PM work would be to add
>>> OCPIF_SWSUP_IDLE flag to our l3_main_2__dss_* slave interfaces(which
>>> have the hack "dss_fck" as slave clock). I gave this approach a try,
>>> that too isn't working so well. When I disable DSS, I get
>>> CM_DSS_DSS_CLKCTRL.IDLEST as 0x1, and
>>> CM_DSS_CLKSTCTRL.CLKACTIVITY_DSS_L3_ICLK is set. I wonder why that's
>>> happening.
>>
>> I have seen DSS get stuck in transition, with just a clkdm state toggle
>> (from say HWSUP to SWWKUP) while its optional clocks are not running.
>> Thats probably whats happening now.
> 
> Oh ok, I can notice that too. So in the _idle() path, the clocks are
> disabled first, and then we try to change the clkdm state. I guess that
> could be the reason why DSS doesn't sleep.
> 
> But then, I don't understand why this problem isn't seen if I try the
> alternative option of removing the fake dss_fck slave clock, and tie
> modulemode to only the parent hwmod. There DSS IDLEST is 0x3 when I
> disable DSS.
> 
> I think with this approach, the problem is with _disable_clocks(), in
> disable_clocks, main_clk is disabled first, and then the slave clocks.
> That translates to DSS_FCK opt clock getting disabled first, and then
> MODULEMODE bits. I think DSS doesn't transition to sleep with this
> disable sequence.
> 
>>
>> Did you try keeping the modulemode enabled and see if it really gates
>> DSS/system sleep. I remember testing with Teros CORE ret/off patches
>> and I was always seeing DSS modulemode enabled but it wasn't gating
>> sleep.
> 
> If the clkdm is in HW_AUTO, I can get DSS in sleep(STBYST and IDLEST all
> set). Is this helpful? Can we just leave modulemode on all the time?
> That'll be the best :)

Well, it is true that in the case of the DSS the modulemode is only
managing the interface clock. And since the interface clock is doing
autogating, it will not prevent clockdomain transition.
But I will not recommend using that, it should not be useful assuming
the clocks are properly managed by the DSS.
I think we still have issue dur to the presence of that fake modulemode
clock node.

Regards,
Benoit
