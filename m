From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 1/5] ARM: gic: Add hooks for architecture specific extensions
Date: Tue, 25 Jan 2011 23:52:51 -0800
Message-ID: <AANLkTikVixQTGMMsh2uteEoV_xRgizAqkZ0Kf7Ggejya@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com>
	<AANLkTi=umZYcb2MozjjLhjjRD305t8iKw2jNr3Ke=9H7@mail.gmail.com>
	<d33cd73f8207d4b92d02eb4bd2629590@mail.gmail.com>
	<AANLkTi=-JYqKW0abCZKDzVjM0DkYF+LMOXDa1R+HrJ2i@mail.gmail.com>
	<ef807d5fb389a19b2bd046f5fc6d203b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:13319 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab1AZHwz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 02:52:55 -0500
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p0Q7qsCP003981
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 23:52:54 -0800
Received: from gyh3 (gyh3.prod.google.com [10.243.50.195])
	by hpaq6.eem.corp.google.com with ESMTP id p0Q7qpJa006726
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 23:52:52 -0800
Received: by gyh3 with SMTP id 3so64463gyh.40
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 23:52:51 -0800 (PST)
In-Reply-To: <ef807d5fb389a19b2bd046f5fc6d203b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Russell King <rmk+kernel@arm.linux.org.uk>

On Tue, Jan 25, 2011 at 11:31 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: ccross@google.com [mailto:ccross@google.com] On Behalf Of
>> Colin Cross
>> Sent: Wednesday, January 26, 2011 12:54 PM
>> To: Santosh Shilimkar
>> Cc: linux-arm-kernel@lists.infradead.org; linux-
>> omap@vger.kernel.org; catalin.marinas@arm.com;
>> linux@arm.linux.org.uk; linus.ml.walleij@gmail.com; Russell King
>> Subject: Re: [PATCH 1/5] ARM: gic: Add hooks for architecture
>> specific extensions
>>
> [....]
>
>> >>
>> > Great.
>> > Can I fold below changes in my patch and add you ack and tested-
>> by?
>>
>> Sure
>
> After reading your initial comment, you mentioned you need to have
> 'gic_set_type' as well. Is this still true. If yes then we need to
> have arch_extn call for that as well.

You are right, I missed adding the extension for gic_set_type.  My
testing doesn't cover that case right now, because I don't have any
drivers updated to linux-next that use a wake source that is
compatible with Tegra's lowest power suspend mode, and that is the
only time the extension to gic_set_type is necessary.

>> >> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> >> index 0b6c043..7993f07 100644
>> >> --- a/arch/arm/common/gic.c
>> >> +++ b/arch/arm/common/gic.c
>> >> @@ -90,6 +90,8 @@ static inline unsigned int gic_irq(struct
>> irq_data
>> >> *d)
>> >> =A0static void gic_ack_irq(struct irq_data *d)
>> >> =A0{
>> >> =A0 =A0 =A0 spin_lock(&irq_controller_lock);
>> >> + =A0 =A0 if (gic_arch_extn.irq_ack)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 gic_arch_extn.irq_ack(d);
>> >> =A0 =A0 =A0 writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
>> >> =A0 =A0 =A0 spin_unlock(&irq_controller_lock);
>> >> =A0}
>> >> @@ -161,6 +163,14 @@ static int gic_set_type(struct irq_data *d,
>> >> unsigned int type)
>> >> =A0 =A0 =A0 return 0;
>> >> =A0}
>> >>
>> >> +static int gic_retrigger(struct irq_data *d)
>> >> +{
>> >> + =A0 =A0 if (gic_arch_extn.irq_retrigger)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return gic_arch_extn.irq_retrigger(d);
>> >> +
>> >> + =A0 =A0 return 0;
>> >> +}
>> >> +
>> >> =A0#ifdef CONFIG_SMP
>> >> =A0static int
>> >> =A0gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val=
,
>> >> bool force)
>> >> @@ -234,6 +244,7 @@ static struct irq_chip gic_chip =3D {
>> >> =A0 =A0 =A0 .irq_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D gic_mask_ir=
q,
>> >> =A0 =A0 =A0 .irq_unmask =A0 =A0 =A0 =A0 =A0 =A0 =3D gic_unmask_ir=
q,
>> >> =A0 =A0 =A0 .irq_set_type =A0 =A0 =A0 =A0 =A0 =3D gic_set_type,
>> >> + =A0 =A0 .irq_retrigger =A0 =A0 =A0 =A0 =A0=3D gic_retrigger,
>> >> =A0#ifdef CONFIG_SMP
>> >> =A0 =A0 =A0 .irq_set_affinity =A0 =A0 =A0 =3D gic_set_cpu,
>> >> =A0#endif
>> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
