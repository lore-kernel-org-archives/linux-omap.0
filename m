From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/9] Fix unsafe disable_irq usage
Date: Sat, 18 Apr 2009 16:38:30 -0700
Message-ID: <200904181638.30794.dmitry.torokhov@gmail.com>
References: <1239861245.29831.113.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1239861245.29831.113.camel@linux-51e8.site>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Ben Nizette <bn@niasdigital.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com, Eric Miao <eric.miao@marvell.com>, linux@arm.linux.org.uk, p_gortmaker@yahoo.com, David Brownell <david-b@pacbell.net>, sameo@linux.intel.com, linux-omap@vger.kernel.org, pierre@ossman.eu, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ben,

On Wednesday 15 April 2009 22:54:05 Ben Nizette wrote:
> After being bitten by unsafe usage of disable_irq from within that irq's
> handler [1], I went through and used Coccinelle to audit the rest of
> drivers/ too.  This turned up 9 more unsafe usages.
>
> As Haavard pointed out in that thread, disable_irq waits for running
> handlers of an irq to complete before returning.  When a handler
> disable_irq's its own irq then we see a deadlock.
>
> Note that this wasn't actually observed in the wild until the recent
> merge of
>
> commit 3aa551c9b4c40018f0e261a178e3d25478dc04a9
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Mar 23 18:28:15 2009 +0100
>
>     genirq: add threaded interrupt handler support
>
>     Add support for threaded interrupt handlers
>
>

Applied all 4 patches affecting input devices, they should show up next
time Linus pulls from me. Thank you.

-- 
Dmitry
