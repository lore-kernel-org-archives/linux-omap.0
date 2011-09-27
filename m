From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH 3/5] [media]: OMAP_VOUT: Fix VSYNC IRQ handling in omap_vout_isr
Date: Tue, 27 Sep 2011 12:21:17 +0530
Message-ID: <CAB2ybb9ZTeyzmv5Do2hySax0WazXOgOnq9NeT-dtLbYi8ROVfg@mail.gmail.com>
References: <1316167233-1437-1-git-send-email-archit@ti.com>
 <1316167233-1437-4-git-send-email-archit@ti.com> <19F8576C6E063C45BE387C64729E739404EC941F86@dbde02.ent.ti.com>
 <4E7AD29C.4070804@ti.com> <19F8576C6E063C45BE387C64729E739404ECA54614@dbde02.ent.ti.com>
 <CAB2ybb8ab9jSFB1J_CQfObB11QcdtQ=6Kf9zdbg0v5Jckf09sw@mail.gmail.com>
 <CAB2ybb-rZgDvS9Bo6AJF=KVd0irXHa0S0LrPJ=SWr0daJ6gX1w@mail.gmail.com>
 <CAB2ybb8UGC=HK7jpYaDym8Y8iy=omwWiXrV7cdRw3k20e0NiZw@mail.gmail.com> <19F8576C6E063C45BE387C64729E739404ECA548CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38730 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751347Ab1I0Gvi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 02:51:38 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404ECA548CF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

Hi Vaibhav,

On Tue, Sep 27, 2011 at 12:09 PM, Hiremath, Vaibhav <hvaibhav@ti.com> w=
rote:
>> -----Original Message-----
>> From: Semwal, Sumit
>> Sent: Tuesday, September 27, 2011 11:12 AM
>> To: Hiremath, Vaibhav
>> Cc: Taneja, Archit; Valkeinen, Tomi; linux-omap@vger.kernel.org; lin=
ux-
>> media@vger.kernel.org
>> Subject: Re: [PATCH 3/5] [media]: OMAP_VOUT: Fix VSYNC IRQ handling =
in
>> omap_vout_isr
>>
>> Hi Vaibhav,
<snip>
>> >>> Archit,
>> >>>
>> >>> I think I am still not understood or convinced with your descrip=
tion
>> above,
>> >>>
>> >>> The code snippet which we are referring here, does check whether=
 the
>> >>> interrupt is either VSYNC or VSYNC2, else fall back to "vout_isr=
_err".
>> >
>> >
>> I am not quite sure I understand what is the confusing part here -
>> below is my understanding; please correct me if you think otherwise.
>> As I understand, this patch creates a (missing) correlation between =
a
>> manager and the corresponding ISR. The earlier code would accept a
>> VSYNC2 for LCD1 manager, which is not the correct thing to do.
>> That is why the check of 'if ((mgr=3D=3DLCD) && (IRQ=3D=3DVSYNC))' k=
ind of
>> thing is needed;=A0Which part of this do you think the above patch
>> doesn't do? Or, do you think it is not needed / done correctly?
> Sumit,
>
> Please look at the patch carefully, it does exactly same thing. I und=
erstand the use-case what Archit explained in the last email but in thi=
s patch context, the use-case change anything here in this patch.
>
> Can you review it carefully again?
Thanks - I did review it carefully (the first time, and again), and
maybe it is something that you're able to see which I can't.

Could you please explain why you think

(1)
if (!(irqstatus & (DISPC_IRQ_VSYNC | DISPC_IRQ_VSYNC2)))
    goto vout_isr_err;

is *exactly* the same as

(2)
 if (!((mgr=3D=3DLCD) && (irqstatus & DISPC_IRQ_VSYNC)) || (mgr=3D=3DLC=
D2) &&
(irqstatus & DISPC_IRQ_VSYNC2)) )
   goto vout_isr_err;
[which I understand is what Archit's patch does]

I am not able to see any correlation in (1) between mgr and irq,
whereas it is quite clear in (2).

Let me know if I missed something?

Best regards,
~Sumit.
>
> Thanks,
> Vaibhav
<snip>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
