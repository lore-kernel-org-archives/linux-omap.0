From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Remaining bits for basic support of LDP
Date: Mon, 2 Feb 2009 21:39:53 +0000
Message-ID: <20090202213953.GB16069@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Miller <davem@davemloft.net>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

Thye LDP platform network interface still doesn't seem to work.  There
seems to be several reasons for this:

1. wrong resource size in arch/arm/mach-omap2/board-ldp.c
2. missing OMAPx4xx configuration from drivers/net/smc911x.h
3. missing SMC9211 chip IDs from drivers/net/smc911x.c

The patch to fix these issues would seem to be relatively small (12
lines in the smc911x and one line change in board-ldp.c) - is it
something we want done for -rc4 or do we scrap the ethernet support 
on the LDP until the SMSC driver has been merged ?

Obviously, having working ethernet would be helpful, and since it was
half heartedly merged when the initial OMAP3 stuff went upstream we
should do something with it one way or another.
