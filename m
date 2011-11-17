From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RESEND #3 6/7] arm: omap: smartreflex: fix IRQ handling bug
Date: Wed, 16 Nov 2011 16:06:08 -0800
Message-ID: <87r51762a7.fsf@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
	<1321346765-16633-7-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321346765-16633-7-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Tue, 15 Nov 2011 10:46:04 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi <balbi@ti.com> writes:

F> fix a bug which has been on this driver since
> it was added by the original commit 984aa6db
> which would never clear IRQSTATUS bits.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Queuing this fix for v3.2-rc (branch: for_3.2/fixes/pm)

Kevin
