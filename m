From: matthias schwarz <matthias.schw@googlemail.com>
Subject: Re: Reading from ISP registers fails
Date: Tue, 21 Jul 2009 13:01:13 +0200
Message-ID: <a187869d0907210401j7c84263fmd31726ed6d2909b7@mail.gmail.com>
References: <a187869d0907210137x4995178au73c34182e6c3d47e@mail.gmail.com>
	 <4A659521.6000606@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:45022 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbZGULBP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 07:01:15 -0400
Received: by bwz28 with SMTP id 28so2509906bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 04:01:14 -0700 (PDT)
In-Reply-To: <4A659521.6000606@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org

2009/7/21 Roger Quadros <ext-roger.quadros@nokia.com>:
> ext matthias schwarz wrote:
>>
>> Hello there,
>>
>> i just wrote a little kernel-module, which only executes the followi=
ng
>> lines of code:
>>
>> u32 syn_mode;
>> void* iomem;
>> struct resource* resource_ptr;
>>
>> resource_ptr =3D request_mem_region(0x480BC000, 0xFFF, "isp_ccdc");
>>
>> iomem =3D ioremap(OMAP3ISP_REG(ISP_SYSCONFIG), 8);
>> if(iomem =3D=3D NULL) {
>> =A0 =A0 =A0 =A0printk("ioremap returned zero\n");
>> =A0 =A0 =A0 =A0return 0;
>> }
>> syn_mode =3D ioread32(iomem);
>>
>>
>>
>> The resulting behaviour does not depend on which ISP register i am
>> trying to read, it also happens for "OMAP3ISP_CCDC_REG_BASE +
>> ISPCCDC_SYN_MODE" for example. And also when using
>> "omap_readl(address)" to read those registers.
>>
>> So when this code is executed i get:
>>
>> Unhandled fault: external abort on non-linefetch (0x1028) at 0xd80bc=
004
>> Internal error: : 1028 [#1] PREEMPT
>> Internal error: : 1028 [#1] PREEMPT
>> Modules linked in:Modules linked in: camera(+) camera(+) ipv6 ipv6
>>
>> CPU: 0 =A0 =A0Not tainted =A0(2.6.28-omap1 #15)
>> [...]
>>
>>
>> Hope someone can help me with what might be wrong.
>> Thank you,
>> Matthias
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> You need to enable interface clocks before accessing any peripheral
> registers.
>
> regards,
> -roger

struct device_driver camera_drv =3D {
        .name =3D "camera"
};

struct device camera_dev =3D {
        .driver =3D &camera_drv,
};

[...]
struct clk* clock;
clock =3D clk_get(&camera_dev, "cam_ick");
clk_enable(clock);
[...]

so this would be it, wouldn't it?

Thank you very much,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
