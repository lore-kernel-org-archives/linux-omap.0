From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [regression] Re: [PATCH 3/7] mfd: twl4030-irq: drop the kthread
Date: Tue, 6 Dec 2011 17:28:58 +0200
Message-ID: <CAMP44s3hFyAK+1W6eU30RNn3=cPDRGKXW+E+sDoWNrNhU0ZpPA@mail.gmail.com>
References: <1309427470-605-1-git-send-email-balbi@ti.com>
	<1309427470-605-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309427470-605-4-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 30, 2011 at 12:51 PM, Felipe Balbi <balbi@ti.com> wrote:
> ... and use threaded IRQ infrastructure. Later
> patches will come dropping both workqueues and
> setting the nested thread flag.

There's something wrong. When I boot my Nokia N900 with this, as soon
as I press a key from the keyboard the whole device hangs. I don't see
anything on the console framebuffer, and with a jig I can't boot from
MMC, so there isn't much more I can provide at the moment.

Cheers.

-- 
Felipe Contreras
