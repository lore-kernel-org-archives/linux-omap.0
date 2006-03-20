From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [RFC] snapshot boot on omap osk 5912
Date: Mon, 20 Mar 2006 11:34:06 +0900 (JST)
Message-ID: <20060320.113406.78713993.kaminaga@sm.sony.co.jp>
References: <20060308.214946.48536311.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060308.214946.48536311.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> Obiously, I missed some initialization staff.
> What I did in step 2) in bootloader is
> 2-1) modified timer to 192MHz for ARM, and enabled mpu, xor, tim
>      clock.
> 2-2) enabled MMU
> (for other device, I hoped resume sequence in kernel would handle...)

I answer myself, Mask Interrupt Register was not setup right, and
it blocked all interrupts. After I unmasked MIR, it got further.

But next problem was that network is not up.
I got:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: INT 0x9d MASK 0x3f MEM 0x0018 FIFO 0x0094
NETDEV WATCHDOG: eth0: transmit timed out
eth0: INT 0x9d MASK 0x3f MEM 0x0018 FIFO 0x0097
end_request: I/O error, dev mtdblock3, sector 256
NETDEV WATCHDOG: eth0: transmit timed out
nfs: server 192.168.0.1 not responding, still trying
nfs: server 192.168.0.1 not responding, still trying

Can someone tell me the steps I have to take to enable network?

# smc91 seems to be working, since kernel is obtained via tftp...


Thanks in advance.

(Hiroki Kaminaga)
t
--
