From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
Date: Wed, 2 May 2012 16:30:26 +0530
Message-ID: <CAMQu2gxcUw5A-p25xdYeXfy=tLbDNPsjV_5MJ6s5qGNfn4Zbfw@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com> <B5906170F1614E41A8A28DE3B8D121433EA6B68E@DBDE01.ent.ti.com>
 <CAMQu2gwCstL6eF92_QBDYZaA5xwxD9a+YWRVxdghA5WVkp4PEQ@mail.gmail.com> <B5906170F1614E41A8A28DE3B8D121433EA6C848@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:55209 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343Ab2EBLAs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 07:00:48 -0400
Received: by obbwd18 with SMTP id wd18so884076obb.28
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 04:00:46 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA6C848@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 2, 2012 at 4:25 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> w=
rote:
> On Wed, May 02, 2012 at 15:48:01, Shilimkar, Santosh wrote:
>> On Wed, May 2, 2012 at 3:40 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com=
> wrote:
>> > Hi Tero,
>> >
>> > On Fri, Apr 20, 2012 at 15:03:34, Kristo, Tero wrote:
>> >> From: Rajendra Nayak <rnayak@ti.com>
>> >>
[...]

>>
>> [...]
>> >> +void omap4_dpll_resume_off(void)
>> >> +{
>> >> + =A0 =A0 u32 i;
>> >> + =A0 =A0 struct omap4_dpll_regs *dpll_reg =3D dpll_regs;
>> >> +
>> >> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(dpll_regs); i++, dpll_reg+=
+) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->clksel);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->div_m2);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->div_m3);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->div_m4);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->div_m5);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->div_m6);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->div_m7);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->clkdcoldo);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Restore clkmode after the above regi=
sters are restored */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->clkmode);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_wait_dpll_lock(dpll_reg);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Restore autoidle settings after the =
dpll is locked */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_=
reg->autoidle);
>> >> + =A0 =A0 }
>> >> +}
>> >
>> > If this function is placed in SRAM and PER PLL restored just after=
 MPU
>> > won't the exit latency be further optimized?
>> >
>> How ?
>> SRAM is sower memory than DDR so I don't see how it
>> will reduce latency.
>>
>
> I am just guessing if that's indeed the case ;)
> Haven't done any measurements to really check if that's indeed the ca=
se though.
>
You don't have to do any real measurements at least on OMAP.
OCMC RAM is interfaced over L4 and MPU has to cross two interconnect
bridges to reach to SRAM. DDR is more of direct path and much faster.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
