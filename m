From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 11/14] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 22 Nov 2010 14:33:45 +0530
Message-ID: <AANLkTimC-Qc242yJGe29+Nbi9vN0UGY+SJDHMzgpQv4q@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com> <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com> <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com> <AANLkTi=R6wZ486qMm+9Ktbhb_w0aysq80JfpE8+ujRL0@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0372E40028@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58112 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318Ab0KVJE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 04:04:27 -0500
Received: by mail-iw0-f173.google.com with SMTP id 5so3169927iwn.32
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 01:04:27 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0372E40028@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On Mon, Nov 22, 2010 at 14:30, DebBarma, Tarun Kanti <tarun.kanti@ti.co=
m> wrote:
>> -----Original Message-----
>> From: Varadarajan, Charulatha
>> Sent: Monday, November 22, 2010 1:55 PM
>> To: DebBarma, Tarun Kanti
>> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, Partha
>> Subject: Re: [PATCHv4 11/14] OMAP2+: dmtimer: convert to platform de=
vices
>>
>> <<snip>>
>>
>> > +/**
>> > + * omap_timer_init - top level timer device initialization
>> > + *
>> > + * uses dedicated hwmod api to parse through hwmod database for
>> > + * given class names and then build and register the timer device=
=2E
>> > + */
>> > +static int __init omap2_dmtimer_device_init(void)
>> > +{
>> > + =A0 =A0 =A0 int ret =3D omap_hwmod_for_each_by_class("timer",
>> omap2_timer_init, NULL);
>> > +
>> > + =A0 =A0 =A0 if (unlikely(ret))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: device registration FA=
ILED\n", __func__);
>> > +
>> > + =A0 =A0 =A0 return ret;
>> > +}
>> > +arch_initcall(omap2_dmtimer_device_init);
>>
>> While introducing this, calls to omap_dm_timer_init() should be
>> removed. Else, the init
>> will happen twice for dmtimer devices
> This function is called only when the switch-over takes place.
> That is why you still see the omap_dm_timer_init().
> So this is more to do with organizing the patch.

Exactly. Please take care of this.

> I could have introduced this init code as part of platform driver
> Swith-over.
>
> --
> Tarun
>
>>
>> > --
>> > 1.6.0.4
>> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
