From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio/omap: fix wakeups on level-triggered GPIOs
Date: Wed, 22 Feb 2012 10:00:45 -0800
Message-ID: <20120222180045.GW18185@atomide.com>
References: <1329850878-22189-1-git-send-email-khilman@ti.com>
 <CAC83ZvKXSwSsU_hu7hrPV6DmVYv=G3iF7Wb5hF_qhSiL+BpfaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58028 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab2BVSAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:00:49 -0500
Content-Disposition: inline
In-Reply-To: <CAC83ZvKXSwSsU_hu7hrPV6DmVYv=G3iF7Wb5hF_qhSiL+BpfaQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120222 08:46]:
> On Wed, Feb 22, 2012 at 12:31 AM, Kevin Hilman <khilman@ti.com> wrote=
:
> > While both level- and edge-triggered GPIOs are capable of generatin=
g
> > interrupts, only edge-triggered GPIOs are capable of generating a
> > module-level wakeup to the PRCM (c.f. 34xx NDA TRM section 25.5.3.2=
=2E)
> >
> > In order to ensure that devices using level-triggered GPIOs as
> > interrupts can also cause wakeups (e.g. from idle), this patch enab=
les
> > edge-triggering for wakeup-enabled, level-triggered GPIOs when a GP=
IO
> > bank is runtime-suspended (which also happens during idle.)
> >
> > This fixes a problem found in GPMC-connected network cards with GPI=
O
> > interrupts (e.g. smsc911x on Zoom3, Overo, ...) where network booti=
ng
> > with NFSroot was very slow since the GPIO IRQs used by the NIC were
> > not generating PRCM wakeups, and thus not waking the system from id=
le.
> > NOTE: until v3.3, this boot-time problem was somewhat masked becaus=
e
> > the UART init prevented WFI during boot until the full serial drive=
r
> > was available. =C2=A0Preventing WFI allowed regular GPIO interrupts=
 to fire
> > and this problem was not seen. =C2=A0After the UART runtime PM clea=
nups, we
> > no longer avoid WFI during boot, so GPIO IRQs that were not causing
> > wakeups resulted in very slow IRQ response times.
> >
> > Tested on platforms using level-triggered GPIOs for network IRQs us=
ing
> > the SMSC911x NIC: 3530/Overo and 3630/Zoom3.
> >
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
>=20
> I have tested on OMAP3430 by making modification to touchscreen GPIO.
> (I had similar change in my next planned cleanup/fix series.)
> If needed you can add my Tested-by:

Work for me too:

Tested-by: Tony Lindgren <tony@atomide.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
