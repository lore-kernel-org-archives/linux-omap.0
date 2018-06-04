From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Mon, 4 Jun 2018 10:42:43 +0100
Message-ID: <20180604094241.GE9482@arm.com>
References: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Fri, Jun 01, 2018 at 12:00:16PM +0100, Russell King wrote:
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
> to the system console.  Two other locations of these loops within the
> ARM code have been identified and fixed up.

Can you confirm that this only happens if CONFIG_ARM_ERRATA_754327=y?
The only erratum I can find for A9 that matches this behaviour exists
when the body of the tight loop contains a DMB and some of the possible
workarounds are:

  - Add ten NOPs after the DMB
  - Use DSB instead of DMB in the tight loop
  - Set bit 16 in the diagnostic control register (p15, c1, 5, 0, c0, 1)

WFE is probably fine (the write-up isn't clear), but if this only occurs
due to CONFIG_ARM_ERRATA_754327=y it would be nice to mitigate it in the
alternative cpu_relax() definition itself, which isn't generally possible
with WFE.

Will
