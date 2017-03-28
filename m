From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCHv3] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Tue, 28 Mar 2017 20:15:24 +0100
Message-ID: <20170328191524.GM23750@n2100.armlinux.org.uk>
References: <20170314180555.23597-1-tony@atomide.com>
 <aa5d7ee3-2e54-2c6c-df5d-b5efff4b365e@ti.com>
 <20170327164308.GK10760@atomide.com>
 <20170328113657.GL23750@n2100.armlinux.org.uk>
 <20170328170944.GY10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170328170944.GY10760@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, "Andrew F. Davis" <afd@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 28, 2017 at 10:09:44AM -0700, Tony Lindgren wrote:
> OK so how about the following to disable kexec for Andrew's
> test case?

That won't work - the hook you're using is to decide whether a particular
CPU (normally the boot CPU) can be hot-plugged.  It isn't expected to
return false for all.

The code in question is:

        /*
         * Validate that if the current HW supports SMP, then the SW supports
         * and implements CPU hotplug for the current HW. If not, we won't be
         * able to kexec reliably, so fail the prepare operation.
         */
        if (num_possible_cpus() > 1 && platform_can_secondary_boot() &&
            !platform_can_cpu_hotplug())
                return -EINVAL;

and:

int platform_can_cpu_hotplug(void)
{
#ifdef CONFIG_HOTPLUG_CPU
        if (smp_ops.cpu_kill)
                return 1;
#endif

        return 0;
}

Platforms don't get a say in that, other than whether they implement
the operations necessary for hotplug.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
