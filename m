From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 15:58:12 +0530
Message-ID: <AANLkTikZXdrjXMq811LR8dQ0eq-QDDUb=pUdBDghWD3E@mail.gmail.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
 <1297693307.2951.25.camel@deskari> <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
 <4D5A00E8.4060701@ti.com> <1297754826.2289.9.camel@deskari>
 <4D5A39AE.3030006@ti.com> <1297759057.2289.40.camel@deskari>
 <4D5A4670.9030405@ti.com> <4D5A5410.1010300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41352 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963Ab1BOK2e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 05:28:34 -0500
Received: by yie16 with SMTP id 16so1554yie.34
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 02:28:32 -0800 (PST)
In-Reply-To: <4D5A5410.1010300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Benoit,

On Tue, Feb 15, 2011 at 3:53 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Archit,
>
> On 2/15/2011 10:25 AM, Taneja, Archit wrote:
>>
>> Copying Benoit,
>>
>> On Tuesday 15 February 2011 02:07 PM, Valkeinen, Tomi wrote:
>>>
>>> On Tue, 2011-02-15 at 02:30 -0600, Taneja, Archit wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tuesday 15 February 2011 12:57 PM, Valkeinen, Tomi wrote:
>>>>
>>>> <snip>
>>>>
>>>>> I meant something like this:
>>>>>
>>>>> dispc.c:
>>>>>
>>>>> dispc_init()
>>>>> {
>>>>> =A0 =A0 =A0 =A0/* did we have a pdev for dispc? if not, this need=
s to be
>>>>> dss.pdev */
>>>>> =A0 =A0 =A0 =A0request_irq(platform_get_irq(dispc.pdev, 0), irq_h=
andler,
>>>>> IRQF_SHARED, "dispc irq", foo);
>>>>> }
>>>>>
>>>>> irq_handler()
>>>>> {
>>>>> =A0 =A0 =A0 =A0if (irq_can_be_shared) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check if the irq is for us. exit i=
f not;
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0handle;
>>>>> }
>>>>>
>>>>> dsi.c:
>>>>>
>>>>> dsi_init()
>>>>> {
>>>>> =A0 =A0 =A0 =A0request_irq(platform_get_irq(dsi.pdev, 0), irq_han=
dler,
>>>>> IRQF_SHARED, "dsi irq", foo);
>>>>> }
>>>>>
>>>>> irq_handler()
>>>>> {
>>>>> =A0 =A0 =A0 =A0if (irq_can_be_shared) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check if the irq is for us. exit i=
f not;
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0handle;
>>>>> }
>>>>>
>>>>
>>>> This approach looks clean, but isn't IRQF_SHARED used the other wa=
y
>>>> around. One irq line and multiple handlers?
>>>
>>> That is the case here, isn't it (on omap3)? One interrupt line (the=
 DSS
>>> irq, the same returned both from dsi.pdev and dispc.pdev), and two
>>> handlers, one in dispc and one in dsi? Or what do you mean?
>>>
>>> On omap2 there's no dsi code ran, so dispc is the only one requesti=
ng
>>> the irq, and thus IRQF_SHARED is extra. In omap4 there are separate=
 irq
>>> lines (dsi.pdev and dispc.pdev return different irqs), and so
>>> IRQF_SHARED is again extra. But I don't see any harm in IRQF_SHARED=
 even
>>> in omap2/4.
>>>
>>> =A0 Tomi
>>>
>>
>> Benoit,
>>
>> Is it okay to have the same irq entry for 2 different hwmods?
>> This requirement comes from OMAP3 where dispc and dsi have a common =
irq
>> line, where as on OMAP4 dispc and dsi have separate irq lines.
>
> Well, no. I explained that in one of my comment about hwmod modificat=
ion.
> The hwmod data are reflecting the exact HW capabilities.
> So, if there is a change in the HW, the hwmod will be different.
> It is up to the driver to adapt to this change.
I guess what Archit wanted to say is, for hw IPs DISPC and DSI, on
OMAP3, have a common IRQ line, so could both their hwmod databases
have the same IRQ added for them? This would us call, for a common IRQ
line shared w/ DISPC and DSI, like
mentioned in Tomi's sample code above.

How is hwmod data for these cases handled today? [shared IRQ,
different platform devices?]

Best regards,
~Sumit.
>
> The driver has to evolve to handle properly the new HW capabilities w=
hile
> keeping the old stuff working.
>
>> We basically want to get rid of a central dss irq handler (hence, re=
move
>> irq entries for dss_core hwmod) and instead have separate irq handle=
rs
>> for each module which may or may not share an irq line.
>
> Then you need to hack your driver but not the hwmod data:-(
>
> Regards,
> Benoit
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
