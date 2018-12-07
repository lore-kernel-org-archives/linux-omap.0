From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Date: Fri, 7 Dec 2018 12:55:33 -0800
Message-ID: <20181207205533.GU6707@atomide.com>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
 <20181206180806.GV6920@n2100.armlinux.org.uk>
 <20181206221447.GM6707@atomide.com>
 <20181207180020.GA9507@n2100.armlinux.org.uk>
 <20181207181420.GS6707@atomide.com>
 <20181207190312.GT6707@atomide.com>
 <20181207192731.GB9507@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207192731.GB9507@n2100.armlinux.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [181207 19:27]:
> You mentioned that edge mode didn't work as well as level mode on
> duovero smsc controller, I think this may help to solve the same
> issue but for edge IRQs - we need a mask_ack_irq function to avoid
> acking while the edge interrupt is masked.  Let me know if that
> lowers the smsc ping latency while in edge mode.

Looks like smsc edge interrupt is still producing varying
ping latencies with this. Seems like the mas_ack_irq is
a nice improvment though.

Regards,

Tony
