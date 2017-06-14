From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH 1/2] arm:omap2+: put omap_uart_phys/virt/lsr in
 .text section when ZIMAGE is true
Date: Wed, 14 Jun 2017 00:24:00 -0700
Message-ID: <20170614072359.GF3730@atomide.com>
References: <1497316206-11110-1-git-send-email-hoeun.ryu@gmail.com>
 <20170614052750.GC3730@atomide.com>
 <1497422926.1935.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497422926.1935.4.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Hoeun Ryu <hoeun.ryu@gmail.com> [170613 23:57]:
> On Tue, 2017-06-13 at 22:27 -0700, Tony Lindgren wrote:
> > So I converted all these to use the 8250 debug_ll yesterday
> > which should solve the DEBUG_UNCOMPRESS issue for you and
> > allows us to remove this file. Will post the series shortly
> > for testing with you in Cc after I've done a bit more testing
> > here.
> 
> It sounds good.
> patch 01 is dropped though, are you using the second patch ?
> "[PATCH 2/2] arm:omap2+: drop dependence on DEBUG_OMAP2PLUS_UART for
> DEBUG_UNCOMPRESS"

I folded it into the patch removing all users of DEBUG_OMAP2PLUS_UART
as that seems to make most sense here.

Regards,

Tony
