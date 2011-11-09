From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Wed, 9 Nov 2011 17:56:36 +0800
Message-ID: <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-5-git-send-email-ming.lei@canonical.com>
	<alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47347 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab1KIJ4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 04:56:37 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RO4tY-00039n-9t
	for linux-omap@vger.kernel.org; Wed, 09 Nov 2011 09:56:36 +0000
Received: by wyh15 with SMTP id 15so1412840wyh.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Nov 2011 01:56:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi,

Thanks for your comments.

On Tue, Nov 8, 2011 at 11:26 PM, Paul Walmsley <paul@pwsan.com> wrote:

>> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] =3D {
>> + =A0 =A0 { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_START },
>> + =A0 =A0 { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_START },
>> + =A0 =A0 { .irq =3D -1 }
>> +};
>
> Are you sure these are part of the emulation IP? =A0We already have t=
hose

I am not sure, I just figure out one way to make omap4 pmu work. Since =
there
are few descriptions in TRM about it, it is a hacking based on [1], :-)

> IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.

I just see it, but looks like the "mpu" hwmod isn't populated as omap_d=
evice,
so the CTI irqs aren't requested now. Also, current arm perf code don't=
 handle
three IRQs(one pl310 irq and two CTI irq) inside one device correctly.

So any suggestion about CTI IRQs connecting to which hwmod, so that the=
y can
be found by pmu driver?

>> +/*emu hwmod*/
>> +static struct omap_hwmod omap44xx_emu_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "emu",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_emu_hwmod_class,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "emu_sys_clkdm",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM=
_EMU_CLKSTCTRL_OFFSET,
>
> This doesn't look right either: EMU is a clockdomain, not an IP block=
=2E

I defined the 'emu' hwmod to control the clock state transition of the =
EMU
clock domain by writing to CLKTRCTRL.CM_EMU_CLKSTCTRL with standard
hwmod interface(_enable / _idle). Is there any other neat way to do it?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODULE=
MODE_HWCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_emu_irqs,
>> +};
>> +
>> =A0static __initdata struct omap_hwmod *omap44xx_hwmods[] =3D {
>>
>> =A0 =A0 =A0 /* dmm class */
c
>
>

[1], http://comments.gmane.org/gmane.comp.embedded.pandaboard/168

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
