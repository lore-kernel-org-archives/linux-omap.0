From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 1/5] ARM: gic: Add hooks for architecture specific extensions
Date: Mon, 24 Jan 2011 19:03:42 -0800
Message-ID: <AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:38707 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab1AYDDq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 22:03:46 -0500
Received: from hpaq13.eem.corp.google.com (hpaq13.eem.corp.google.com [172.25.149.13])
	by smtp-out.google.com with ESMTP id p0P33iTQ029210
	for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 19:03:45 -0800
Received: from gxk9 (gxk9.prod.google.com [10.202.11.9])
	by hpaq13.eem.corp.google.com with ESMTP id p0P33gog026327
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 19:03:43 -0800
Received: by gxk9 with SMTP id 9so1535177gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 19:03:42 -0800 (PST)
In-Reply-To: <1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Russell King <rmk+kernel@arm.linux.org.uk>

On Mon, Jan 24, 2011 at 12:51 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Few architectures combine the GIC with an external interrupt controll=
er.
> On such systems it may be necessary to update both the GIC registers
> and the external controller's registers to control IRQ behavior.
>
> This can be addressed in couple of possible methods.
> =A01. =A0 =A0 Export common GIC routines along with 'struct irq_chip =
gic_chip'
> =A0 =A0 =A0 =A0and allow architectures to have custom function by ove=
rride.
>
> =A02. =A0 =A0 Provide architecture specific function pointer hooks
> =A0 =A0 =A0 =A0within GIC library and leave platforms to add the nece=
ssary
> =A0 =A0 =A0 =A0code as part of these hooks.
>
> First one might be non-intrusive but have few shortcomings like arch =
needs
> to have there own custom gic library. Locks used should be common sin=
ce it
> caters to same IRQs etc. Maintenance point of view also it leads to
> multiple file fixes.
>
> The second probably is cleaner and portable. It ensures that all the
> common GIC infrastructure is not touched and also provides archs to
> address their specific issue.

This method would work for most of Tegra's needs, although we would
need gic_set_type and gic_ack_irq to have arch extensions as well.
However, it does not allow for irq_retrigger, which can be implemented
on Tegra.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
