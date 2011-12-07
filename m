From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [regression] Re: [PATCH 3/7] mfd: twl4030-irq: drop the kthread
Date: Wed, 7 Dec 2011 20:32:46 +0200
Message-ID: <CAMP44s1Smts_TgHhxbdQZS0eM=hwVR8+H2i9AcMEzL_W=Guo6A@mail.gmail.com>
References: <1309427470-605-1-git-send-email-balbi@ti.com>
	<1309427470-605-4-git-send-email-balbi@ti.com>
	<CAMP44s3hFyAK+1W6eU30RNn3=cPDRGKXW+E+sDoWNrNhU0ZpPA@mail.gmail.com>
	<20111207065106.GE32368@legolas.emea.dhcp.ti.com>
	<CAMP44s0psqeMEh8vgYSfV=MAqSOJ6+EpWndXpc89qfGHMX_f=w@mail.gmail.com>
	<20111207223003.0a0ae278@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111207223003.0a0ae278@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 7, 2011 at 1:30 PM, NeilBrown <neilb@suse.de> wrote:
> =C2=A0Try the patches I posted to linux-kernel on Nov 27:
>
> =C2=A0 Subject: [PATCH 0/4] fixes for twl4030-irq in mainline
>
> and following
>
> =C2=A0 http://lkml.org/lkml/2011/11/26/92
>
> I think I hit exactly the same bug and you and (eventually) fix it (t=
hat was
> a fun learning experience).

Yeap, those patches fix the issue :)

Cheers.

--=20
=46elipe Contreras
