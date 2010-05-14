From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 14:53:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141441220.3348@utopia.booyaka.com>
References: <Pine.LNX.4.44L0.1005040949060.1729-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005040949060.1729-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org


Hello,

On Tue, 4 May 2010, Alan Stern wrote:

> Another thing that Kevin is missing: There is more to the system than
> the devices and the CPU.  For example: RAM, an embedded controller (on
> modern desktop/laptop systems), a power supply, and so on.  Dynamic PM
> for the CPU and the devices won't power-down these things, but system
> PM will.

No.  A dynamic PM-based kernel can, and in the case of the mainline Linux 
code running on OMAP, does, power down RAM[1] and the power supply[2].

Since the CPU is already powered off when it is time for this to happen, 
so this is done under autonomous hardware control.  We currently use 
CPUIdle[3] to choose whether to program the SoC hardware to enable this 
autonomous power control before it goes off, depending on the required 
wakeup latency for timers and PM constraints.


- Paul


1. (technically, put the RAM into self-refresh mode): 
   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/sleep34xx.S/sleep34xx.S;h=d522cd70bf53485d0a3af2453845777e3a89edd7;hb=4fc4c3ce0dc1096cbd0daa3fe8f6905cbec2b87e#l204

2. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/sleep34xx.S/sleep34xx.S;h=d522cd70bf53485d0a3af2453845777e3a89edd7;hb=4fc4c3ce0dc1096cbd0daa3fe8f6905cbec2b87e#l204

3. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/cpuidle34xx.c;h=3d3d035db9aff62ce522e0080e570cfdbf8e70cc;hb=4462dc02842698f173f518c1f5ce79c0fb89395a#l292
