From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/7] mfd: twl4030-irq: drop the kthread
Date: Mon, 12 Dec 2011 19:48:41 +0200
Message-ID: <CAMP44s03Cj+V_L8GKyWLMuCGQ5Fg9nZ+Uxm5DpwVVF3YY0RSqA@mail.gmail.com>
References: <1309427470-605-1-git-send-email-balbi@ti.com>
	<1309427470-605-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59037 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1LLRsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 12:48:41 -0500
In-Reply-To: <1309427470-605-4-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jun 30, 2011 at 12:51 PM, Felipe Balbi <balbi@ti.com> wrote:
> ... and use threaded IRQ infrastructure. Later
> patches will come dropping both workqueues and
> setting the nested thread flag.

=2E..

> =C2=A0static irqreturn_t handle_twl4030_pih(int irq, void *devid)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 /* Acknowledge, clear *AND* mask the interrupt=
=2E.. */
> - =C2=A0 =C2=A0 =C2=A0 disable_irq_nosync(irq);
> - =C2=A0 =C2=A0 =C2=A0 complete(devid);

=2E..

> - =C2=A0 =C2=A0 =C2=A0 status =3D request_irq(irq_num, handle_twl4030=
_pih, IRQF_DISABLED,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "TWL4030-PIH", &irq_event);
> + =C2=A0 =C2=A0 =C2=A0 status =3D request_threaded_irq(irq_num, NULL,=
 handle_twl4030_pih,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 IRQF_DISABLED, "TWL4030-PIH", NULL);

=46TR, in this reorganization this code was dropped
disable_irq_nosync(irq), which means the irq's would never be cleared.
IRQF_ONESHOT should have been on the flags.

But Neil Brown already found the issue and fixed it :)
http://article.gmane.org/gmane.linux.kernel/1220705

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
