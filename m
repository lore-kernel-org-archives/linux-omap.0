From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Mon, 27 Mar 2017 09:43:09 -0700
Message-ID: <20170327164308.GK10760@atomide.com>
References: <20170314180555.23597-1-tony@atomide.com>
 <aa5d7ee3-2e54-2c6c-df5d-b5efff4b365e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <aa5d7ee3-2e54-2c6c-df5d-b5efff4b365e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [170327 09:36]:
> On 03/14/2017 01:05 PM, Tony Lindgren wrote:
> > Commit 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec") started
> > unconditionally resetting CPU1 because of a kexec boot issue I was seeing
> > earlier on omap4 when doing kexec boot between two different kernel
> > versions.
> > 
> > This caused issues on some systems. We should only reset CPU1 as a last
> > resort option, and try to avoid it where possible. Doing an unconditional
> > CPU1 reset causes issues for example when booting a bootloader configured
> > secure OS running on CPU1 as reported by Andrew F. Davis <afd@ti.com>.
> > 
> > We can't completely remove the reset of CPU1 as it would break kexec
> > booting from older kernels. But we can limit the CPU1 reset to cases
> > where CPU1 is wrongly parked within the memory area used by the booting
> > kernel. Then later on we can add support for parking CPU1 for kexec out
> > of the SDRAM back to bootrom.
> > 
> > So let's first fix the regression reported by Andrew by making CPU1 reset
> > conditional. To do this, we need to:
> > 
> > 1. Save configured AUX_CORE_BOOT_1 for later
> > 
> > 2. Modify AUX_CORE_BOOT_0 reading code to for HS SoCs to return
> >    the whole register instead of the CPU mask
> > 
> > 3. Check if CPU1 is wrongly parked into the booting kernel by the
> >    previous kernel and reset if needed
> > 
> 
> I still don't like this style of workaround, if kexec cannot regain
> control of core1 without a hard core reset than kexec should BUG() and
> force the user to reboot to a sane state.

Yes problems still remains. I think the immediate fix there is to
disable kexec during runtime based on some criteria for your use
case rather than BUG() though. Somehow kexec needs to know if CPU1
reset is acceptable, then reset CPU1 before kexec.

> Anyway, this patch does remove the unconditional reset and fixes my
> use-case is some situations (when not using kexec) so:
> 
> Tested-by: Andrew F. Davis <afd@ti.com>

OK thanks for testing.

Regards,

Tony
