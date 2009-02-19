From: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Subject: [patch 10/12] USB: musb: Disable USB interrupt in the
	musb_resume() function
Date: Wed, 18 Feb 2009 21:48:41 -0800
Message-ID: <20090219054841.GK26729@kroah.com>
References: <20090219052749.125178129@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename="usb-musb-disable-usb-interrupt-in-the-musb_resume-function.patch"
In-Reply-To: <20090219054750.GA26729-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, =?iso-8859-1?B?6rk/6rc/7D8/?= <q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

USB should be suspended with interrupt disabled[1]. If USB is suspended with
interrupt enabled and connected to host PC, a kernel panic would occur When
it wakes up. Because, after the arch_suspend_enable_irqs() function is called
in the suspend_enter() function, USB Interrupt handler is called, even though
USB controller is still not resumed! All devices are resumed after the
device_resume() is called.

[1] /Documentation/power/devices.txt: 412 line

Signed-off-by: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

---
 drivers/usb/musb/musb_core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2151,6 +2151,8 @@ static int musb_suspend(struct platform_
 
 	spin_lock_irqsave(&musb->lock, flags);
 
+	disable_irq(musb->nIrq);
+
 	if (is_peripheral_active(musb)) {
 		/* FIXME force disconnect unless we know USB will wake
 		 * the system up quickly enough to respond ...
@@ -2184,6 +2186,8 @@ static int musb_resume(struct platform_d
 	else
 		clk_enable(musb->clock);
 
+	enable_irq(musb->nIrq);
+
 	/* for static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down and we're
 	 * not treating that as a whole-system restart (e.g. swsusp)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
