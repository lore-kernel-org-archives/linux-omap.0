From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP4 clock/pm fixes [was: [PATCH v4 2/3] ARM: omap: hwmod: get
 rid of all omap_clk_get_by_name usage
Date: Fri, 5 Oct 2012 19:16:28 +0530
Message-ID: <506EE4B4.6010903@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com> <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com> <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com> <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com> <1346397309.18766.5.camel@lappyti> <504073CF.6010804@ti.com> <1346401643.32389.4.camel@deskari> <504075A0.7010708@ti.com> <506EAC89.2070307@ti.com> <506ED079.70700@ti.com> <506ED29E.7070403@ti.com> <506ED492.5010709@ti.com> <506EDEB3.3050003@ti.com> <506EE14E.4080500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44138 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab2JENqn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 09:46:43 -0400
In-Reply-To: <506EE14E.4080500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>

On Friday 05 October 2012 07:01 PM, Rajendra Nayak wrote:
>> If the clkdm is in HW_AUTO, I can get DSS in sleep(STBYST and IDLEST all
>> set). Is this helpful? Can we just leave modulemode on all the time?
>> That'll be the best :)
>
> Is everything around DSS enabled by default in omap2plus? If so, I
> haven't seen Tero (who has been working on getting OMAP4 to sleep)
> complain about DSS causing him any trouble. So you should be good
> with whats already there atleast from 'not-gating-sleep' point of
> view.

DSS is selected only as a module in omap2plus_defconfig, so the DSS 
driver would never kick in with the defconfig.

The DSS hwmods would be initialised though. If I boot up linux-next with 
omap2plus_defconfig, I get:

CM_DSS_CLKSTCTRL 0x3
CM_DSS_DSS_CLKCTRL 0x00060002

So the module is in standby, but IDLEST is 0x2, which says DSS is idle 
only with respect to the interconnect. In the bootloader, IDLEST was 
0x3. So I don't know if that's a good thing or not.

Archit

