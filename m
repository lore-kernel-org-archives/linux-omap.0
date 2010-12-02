From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC v2 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Thu, 2 Dec 2010 16:01:43 +0530
Message-ID: <AANLkTinQPsz2LjMdyxKfpg5eotEhTHYig427Gu_Q_6_K@mail.gmail.com>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
 <1291147139-23472-2-git-send-email-davidsin@ti.com> <AANLkTi=q1HzYBpMH_pP+S5BtBQpHs62+zNfd_MtWHFuu@mail.gmail.com>
 <AANLkTi=YUYuxQE8pDZrN5-PJq1Q3jw7cP2yZKCXNAvPP@mail.gmail.com>
 <AANLkTik1o4Ka_UnwWvmjVhQGrPwrOpPGG4mmu4zSiH+U@mail.gmail.com>
 <AANLkTikEY+0gGB9dbVFZvhwWbd5jGEGo7oDNs_y5xL=s@mail.gmail.com> <AANLkTim6vtSnGrTXjy71UVu79+3QgHcUv3+7AWP=DTgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTim6vtSnGrTXjy71UVu79+3QgHcUv3+7AWP=DTgA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, David Sin <davidsin@ti.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lajos Molnar <molnar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 2, 2010 at 15:53, Hari Kanigeri <hari.kanigeri@gmail.com> w=
rote:
> On Wed, Dec 1, 2010 at 11:16 PM, Varadarajan, Charulatha <charu@ti.co=
m> wrote:
>> On Thu, Dec 2, 2010 at 07:57, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
>>> On Wed, Dec 1, 2010 at 8:10 PM, Kanigeri, Hari <h-kanigeri2@ti.com>=
 wrote:
>>>> On Wed, Dec 1, 2010 at 12:04 AM, Varadarajan, Charulatha <charu@ti=
=2Ecom> wrote:
>>>>> David,
>>>>
>>>>>
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh)
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>>>>>> +
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->base =3D oh->_mpu_rt_va;
>>>>>
>>>>> not required. Make use of platform_get APIs in probe to extract t=
he
>>>>> base, dma and irq info using pdev.
>>>>
>>>> Not sure about using platform_get APIs. I think one has to use
>>>> omap_hwmod_get_mpu_rt_va to get the address, which internally retu=
rns
>>>> oh-<_mpu_rt_va.
>>> small correction... omap_device_get_rt_va and not omap_hwmod_get_mp=
u_rt_va.
>>
>> To get the base address & irq, you need not have to use
>> omap_device_get_rt_va and pass it as
>> pdata and then use it during probe. Instead in probe, you may do
>> something like the following:
>
> If hwmod framework is already doing the ioremap on device address,
> then it is better to use it rather than duplicating the ioremap part
> again in probe function.
> From what I understand regarding omap_device_get_rt_va() function, it
> is added so that Driver's can avoid doing ioremap.
> check Santosh's comment on this API
> http://www.spinics.net/lists/arm-kernel/msg92260.html

Okay. For base address, I agree, as it avoids redoing ioremap in driver=
s.
=46or "irq" & "DMA", it is still required to use platform_get*() APIs.

>
>>
>> static int __devinit =A0dev_probe (*pdev) {
>> =A0 struct resource *res;
>> =A0 void __iomem *base;
>> =A0 u16 irq;
>> =A0 ....
>> =A0 ....
>> =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> =A0 if (unlikely(!res)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0....
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> =A0 }
>>
>> =A0 base =3D ioremap(res->start, resource_size(res));
>> =A0 if (base) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ....
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 }
>>
>> =A0 res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> =A0 if (unlikely(!res)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ....
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 }
>> =A0 irq =3D res->start;
>> =A0 ....
>> =A0 ....
>> }
>>
>> -V Charulatha
