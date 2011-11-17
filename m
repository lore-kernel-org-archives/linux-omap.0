From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RESEND #3 0/7] SmartReflex Patches
Date: Wed, 16 Nov 2011 16:09:03 -0800
Message-ID: <87obwb625c.fsf@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321346765-16633-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Tue, 15 Nov 2011 10:45:58 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

+Jean

Felipe Balbi <balbi@ti.com> writes:

> here's a bunch of patches to smartreflex which have been pending
> for months.

The SmartReflex code is going through a major rework by Jean so it can be
converted into a real driver and moved under drivers/*.

I'll leave it to Jean to incorporate these changes into his rework as he
sees fit, although I've queued the IRQ fix for v3.2-rc.

Kevin
