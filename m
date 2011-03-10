From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] OMAP3: wdtimer: fix wdtimer blocking CORE idle
Date: Thu, 10 Mar 2011 16:25:51 +0100
Message-ID: <4D78ED7F.1020307@ti.com>
References: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com> <alpine.DEB.2.00.1103100247190.15132@utopia.booyaka.com> <9D0D31AA57AAF5499AFDC63D6472631B065E79@008-AM1MPN1-036.mgdnok.nokia.com> <4D78B290.7070905@ti.com> <alpine.DEB.2.00.1103100604460.15132@utopia.booyaka.com> <4D78D803.6080309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58529 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab1CJPZ7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 10:25:59 -0500
In-Reply-To: <4D78D803.6080309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "kalle.jokiniemi@nokia.com" <kalle.jokiniemi@nokia.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ilkka.koskinen@nokia.com" <ilkka.koskinen@nokia.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>

Paul,

On 3/10/2011 2:54 PM, Cousson, Benoit wrote:
> On 3/10/2011 2:08 PM, Paul Walmsley wrote:
>> Hi Beno=EEt,
>>
>> On Thu, 10 Mar 2011, Cousson, Benoit wrote:
>>
>>> On 3/10/2011 11:28 AM, kalle.jokiniemi@nokia.com wrote:
>>>>
>>>>> From: ext Paul Walmsley [mailto:paul@pwsan.com]
>>>>> Sent: 10. maaliskuuta 2011 11:50
>>>>>
>>>>> Thanks Kalle for tracking this down,
>>>>>
>>>>> could you try this patch along with the patch from this message:
>>>>>
>>>>>      http://www.spinics.net/lists/linux-omap/msg48115.html
>>>
>>> I have some question with that patch.
>>> By using pm_runtime API, you are suppose to idle the whole IP.
>>> In this case, just because you cannot idle a wdt that is running, i=
t works,
>>> but the point is that the pm_runtime state will not reflect the HW =
state.
>>> For pm_runtime point of view, the wdt is supposed to be fully idle =
(both fclk
>>> and iclk). Whereas in that case, only the iclk will be gated.
>>>
>>> Did I miss something?
>>
>> Looking at it, I don't know how the old driver managed to work at al=
l.
>> Commit 7ec5ad0f3c1e28b693185c35f768953c5db32291 ("OMAP: WDT: Use PM
>> runtime APIs instead of clk FW APIs") removed this from omap_wdt_pro=
be():
>>
>> -       /* autogate OCP interface clock */
>> -       __raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
>>
>> This would put the WDTIMER into force-idle, and nothing ever took it=
 out
>> of force-idle.  So I don't quite understand why the PRCM wouldn't ju=
st
>> turn off the functional clock to the WDTIMER at this point.  Any tho=
ughts
>> on this?
>
> The idle definition of the PRCM is just: idle of the ocp clock (iclk)=
=2E
> The fclk can be active while the module is "idle" for the PRCM point =
of
> view.
> That's why we have a mismatch in that case with the pm_runtime idle
> definition, where the module should be fully idle.
>
> In that case, since the WDT is in the wakeup domain, we do not even h=
ave
> to re-enable the iclk since the wakeup domain is always on whenever t=
he
> MPU is running.
>
> That fact that we have to explicitly do a force idle, probably means
> that the autoidle is broken in the IP.

Meanwhile, this patch is probably the best approach anyway.
I do not like going backward with a clock level management solution.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
