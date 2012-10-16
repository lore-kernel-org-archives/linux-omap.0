From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Revert "serial: omap: fix software flow control"
Date: Tue, 16 Oct 2012 08:13:59 -0700
Message-ID: <20121016151357.GN15569@atomide.com>
References: <1350396562-32579-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350396562-32579-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [121016 07:16]:
> This reverts commit 957ee7270d632245b43f6feb0e70d9a5e9ea6cf6
> (serial: omap: fix software flow control).
> 
> As Russell has pointed out, that commit isn't fixing
> Software Flow Control at all, and it actually makes
> it even more broken.
> 
> It was agreed to revert this commit and use Russell's
> latest UART patches instead.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

This seems like the best way to go for the -rc series:

Acked-by: Tony Lindgren <tony@atomide.com>
