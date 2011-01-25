From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 1/5] ARM: gic: Add hooks for architecture specific extensions
Date: Tue, 25 Jan 2011 12:54:55 -0800
Message-ID: <AANLkTi=umZYcb2MozjjLhjjRD305t8iKw2jNr3Ke=9H7@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:7366 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab1AYUzC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 15:55:02 -0500
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id p0PKsum1014115
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 12:54:57 -0800
Received: from qyk12 (qyk12.prod.google.com [10.241.83.140])
	by kpbe11.cbf.corp.google.com with ESMTP id p0PKsSHx008909
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 12:54:56 -0800
Received: by qyk12 with SMTP id 12so216817qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 12:54:56 -0800 (PST)
In-Reply-To: <AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Russell King <rmk+kernel@arm.linux.org.uk>

On Mon, Jan 24, 2011 at 7:03 PM, Colin Cross <ccross@android.com> wrote=
:
> On Mon, Jan 24, 2011 at 12:51 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Few architectures combine the GIC with an external interrupt control=
ler.
>> On such systems it may be necessary to update both the GIC registers
>> and the external controller's registers to control IRQ behavior.
>>
>> This can be addressed in couple of possible methods.
>> =A01. =A0 =A0 Export common GIC routines along with 'struct irq_chip=
 gic_chip'
>> =A0 =A0 =A0 =A0and allow architectures to have custom function by ov=
erride.
>>
>> =A02. =A0 =A0 Provide architecture specific function pointer hooks
>> =A0 =A0 =A0 =A0within GIC library and leave platforms to add the nec=
essary
>> =A0 =A0 =A0 =A0code as part of these hooks.
>>
>> First one might be non-intrusive but have few shortcomings like arch=
 needs
>> to have there own custom gic library. Locks used should be common si=
nce it
>> caters to same IRQs etc. Maintenance point of view also it leads to
>> multiple file fixes.
>>
>> The second probably is cleaner and portable. It ensures that all the
>> common GIC infrastructure is not touched and also provides archs to
>> address their specific issue.
>
> This method would work for most of Tegra's needs, although we would
> need gic_set_type and gic_ack_irq to have arch extensions as well.
> However, it does not allow for irq_retrigger, which can be implemente=
d
> on Tegra.

irq_retrigger does work with this method, the core IRQ code checks for
a return value if the retrigger was successful.  Tegra works with your
patch along with these changes:

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 0b6c043..7993f07 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -90,6 +90,8 @@ static inline unsigned int gic_irq(struct irq_data *d=
)
 static void gic_ack_irq(struct irq_data *d)
 {
 	spin_lock(&irq_controller_lock);
+	if (gic_arch_extn.irq_ack)
+		gic_arch_extn.irq_ack(d);
 	writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 	spin_unlock(&irq_controller_lock);
 }
@@ -161,6 +163,14 @@ static int gic_set_type(struct irq_data *d,
unsigned int type)
 	return 0;
 }

+static int gic_retrigger(struct irq_data *d)
+{
+	if (gic_arch_extn.irq_retrigger)
+		return gic_arch_extn.irq_retrigger(d);
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static int
 gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val, bool f=
orce)
@@ -234,6 +244,7 @@ static struct irq_chip gic_chip =3D {
 	.irq_mask		=3D gic_mask_irq,
 	.irq_unmask		=3D gic_unmask_irq,
 	.irq_set_type		=3D gic_set_type,
+	.irq_retrigger		=3D gic_retrigger,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	=3D gic_set_cpu,
 #endif
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
