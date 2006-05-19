From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [patchset] Generic IRQ Subsystem: -V5
Date: Fri, 19 May 2006 15:11:15 -0700
Message-ID: <1148076675.9331.35.camel@vence.internal.net>
References: <20060519145310.GB12703@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060519145310.GB12703@elte.hu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, 2006-05-19 at 16:53 +0200, Ingo Molnar wrote:
> This is Version 5 of the genirq patch-queue, against 2.6.17-rc4. 

I've tested -V5 on various OMAP boards (1710/H3, 1623/H2, and 5912/OSK)
and all have the same network TX timeout problems when booting using
nfsroot.  Eventually, they boot to a prompt, but continue to have
periodic timeouts when accessing NFS files.

On all 3 boards, the network driver is the smc91x and the IRQ is a GPIO
interrupt.  

Just and FYI... I'm still digging for root cause.

Kevin
