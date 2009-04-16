From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH 0/9] Fix unsafe disable_irq usage
Date: Thu, 16 Apr 2009 15:54:05 +1000
Message-ID: <1239861245.29831.113.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755511AbZDPFyu@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: dan.j.williams@intel.com, Eric Miao <eric.miao@marvell.com>, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, p_gortmaker@yahoo.com, David Brownell <david-b@pacbell.net>, sameo@linux.intel.com, linux-omap@vger.kernel.org, pierre@ossman.eu, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

After being bitten by unsafe usage of disable_irq from within that irq's
handler [1], I went through and used Coccinelle to audit the rest of
drivers/ too.  This turned up 9 more unsafe usages.

As Haavard pointed out in that thread, disable_irq waits for running
handlers of an irq to complete before returning.  When a handler
disable_irq's its own irq then we see a deadlock.

Note that this wasn't actually observed in the wild until the recent
merge of

commit 3aa551c9b4c40018f0e261a178e3d25478dc04a9
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Mar 23 18:28:15 2009 +0100

    genirq: add threaded interrupt handler support

    Add support for threaded interrupt handlers



Regards,
	--Ben.


[1] http://lkml.org/lkml/2009/4/15/498
