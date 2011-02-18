From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and DSI
Date: Fri, 18 Feb 2011 03:45:11 -0600
Message-ID: <AANLkTik119ZB8+mR-MzXHUbZdxDo966HWehE8LeCxpWZ@mail.gmail.com>
References: <1297952702-13419-1-git-send-email-archit@ti.com>
 <91F20383AC6A5F4DB94C692112281213B4C15EBB91@dlee07.ent.ti.com> <4D5E3D35.9000902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55224 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753967Ab1BRJpd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 04:45:33 -0500
Received: by vws6 with SMTP id 6so1740026vws.6
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 01:45:31 -0800 (PST)
In-Reply-To: <4D5E3D35.9000902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit taneja <archit@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, Feb 18, 2011 at 3:34 AM, archit taneja <archit@ti.com> wrote:
> Hi,
>
> On Friday 18 February 2011 02:40 PM, Valkeinen, Tomi wrote:
>>
>> Hi,
>>
>> On Thu, 2011-02-17 at 08:25 -0600, Taneja, Archit wrote:
>>>
>>> Currently, the core DSS platform device requests for an irq line fo=
r
>>> OMAP2 and
>>> OMAP3. Make DISPC and DSI platform devices request for a shared IRQ=
 line.
>>>
>>> On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to t=
he
>>> MPU. There
>>> is a register DSS_IRQSTATUS which tells if the interrupt came from =
DISPC
>>> or DSI.
>>>
>>> On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. Ther=
e is
>>> no
>>> DSS_IRQSTATUS register.
>>>
>>> Hence, it makes more sense to have separate irq handlers correspond=
ing to
>>> the
>>> DSS sub modules instead of having a common handler.
>>>
>>> Since on OMAP3 the logical OR of the lines goes to MPU, the irq lin=
e is
>>> shared
>>> among the IRQ handlers.
>>>
>>> The hwmod irq info has been removed for DSS to DISPC and DSI for OM=
AP2
>>> and OMAP3
>>> hwmod databases. The Probes of DISPC and DSI now request for irq
>>> handlers. A dss
>>> feature is also added to tell whether the irq lines is shared betwe=
en
>>> DISPC and
>>> DSI or not.
>>
>> Yes, I think this looks much cleaner.
>>
>> However, I'm not sure if it's necessary to check the DSS_IRQSTATUS. =
It
>> depends a bit on how DSS_IRQSTATUS works. If it just mirrors the
>> DISPC/DSI_IRQSTATUS (ie, if there's any bit up in DSI_IRQSTATUS, the=
 DSI
>> bit in DSS_IRQSTATUS is up), we can do without it.
>>
>> For example let's say we haven't enabled any interrupts in DSI, so
>> preferably we want to spend as little time in the dsi irq handler as
>> possible.
>>
>> Now, if DSI_IRQSTATUS is all zeroes, and thus DSS_IRQSTATUS.DSI is a=
lso
>> zero, we can skip the DSI handler by checking DSS_IRQSTATUS.DSI as y=
ou
>> do in this patch. But we could as well check DSI_IRQSTATUS, and exit=
 if
>> it's all zeroes.
>>
>> If, on the other hand, DSI_IRQSTATUS has any bit up, then also
>> DSS_IRQSTATUS.DSI is up, and we have to check the DSI interrupts any=
way.
>>
>> So in both cases the end result is the same, and we can do with less
>> code by not using DSS_IRQSTATUS.
>>
>> However, I'm not 100% sure DSS_IRQSTATUS works like that, but it wou=
ld
>> sound logical and I don't know how could it work otherwise.
>
> I can give it a try.
>
> There is a figure in the OMAP3 TRM titled "DISPC and DSS Interrupts t=
ree"
> which shows its logical OR. How the bits are set in DSS_IRQSTATUS is =
not
> mentioned anywhere though

PRM_IRQSTATUS_* registers will have status bits set even when the
corresponding PRM_IRQENABLE_* bits are not set.  The common assumption
was that status bits would not be set if interrupts weren't enabled
and this caused us some issues in prcm_interrupt_handler some time
back.  I don't know how DSS_IRQSTATUS works under the hood, but be
careful of such assumptions :-)

Regards,
Mike

>>
>> =A0Tomi
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
