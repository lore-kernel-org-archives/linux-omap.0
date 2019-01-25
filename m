From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Fri, 25 Jan 2019 15:20:20 -0800
Message-ID: <20190125232020.GX5720@atomide.com>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King <rmk+kernel@armlinux.org.uk> [190125 21:04]:
> Executing loops such as:
> 
> 	while (1)
> 		cpu_relax();
> 
> with interrupts disabled results in a livelock of the entire system,
> as other CPUs are prevented making progress.  This is most noticable
> as a failure of crashdump kexec, which stops just after issuing:
> 
> 	Loading crashdump kernel...
> 
> to the system console.  A workaround for this is to use 10 nops in
> cpu_relax().
> 
> We also use wfe() in while (1) loops to avoid burning cycles in a
> tight loop, giving the CPU a hint that we're not doing anything
> useful.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> It's been a while since this was posted, Will's suggestion was to use
> 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> these infinite-not-doing-anything-ever loops.

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
