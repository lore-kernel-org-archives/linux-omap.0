From: Nick Krause <xerofoify@gmail.com>
Subject: omap-wakeupgen.c: Remove function for fix me
Date: Tue, 22 Jul 2014 17:09:51 -0400
Message-ID: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

static void __init irq_pm_init(void)
382 {
383         /* FIXME: Remove this when MPU OSWR support is added */
384         if (!soc_is_omap54xx())
385                 cpu_pm_register_notifier(&irq_notifier_block);
386 }
I am wondering is this omap supported now if it is can I remove it?
Cheers Nick
