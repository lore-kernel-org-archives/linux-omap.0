From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting cpu1
 during boot
Date: Fri, 17 Feb 2017 14:27:07 -0600
Message-ID: <45e4f34e-833d-77df-bc3d-f5852f614d5d@ti.com>
References: <20170213215013.19929-1-tony@atomide.com>
 <20170214193645.GM21809@atomide.com> <20170215183915.GU3897@atomide.com>
 <20170215191242.GP21809@atomide.com>
 <ca389104-df6f-b055-ec43-524d82cf1be7@ti.com>
 <20170215222711.GQ21809@atomide.com> <20170216161010.GU21809@atomide.com>
 <fc1e75e8-87ef-59f1-3c8a-cb45f1749e50@ti.com>
 <20170216165409.GW21809@atomide.com> <20170216190701.GY21809@atomide.com>
 <20170217155502.GD21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170217155502.GD21809@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/17/2017 09:55 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170216 11:08]:
>> * Tony Lindgren <tony@atomide.com> [170216 08:55]:
>>> For your use case, probably all we need is runtime checks for HS in
>>> addition to parking cpu1 for kexec. If that's not enough, then maybe
>>> a device specific DT property for never-reset-no-matter-what.
>>
>> Below is a first take on the last resort cpu1 reset done based on
>> configured CPU1_WAKEUP_NS_PA_ADDR_OFFSET for omap4 and 5. Note that
>> we can't merge it yet as it will break kexec boot for dra7. To fix that,
>> we need to first do what you're suggesting and properly park cpu1 for
>> kexec.
> 
> Something like the patch below might be doable for the first fix
> before we have something to park cpu1 for kexec. I've added more checks
> to attemp to detect cpu1 being in WFI. At least things keep on working
> for kexec on omap4/5 and GP dra7.
> 
> Andrew, care to give it a try and see if can add some HS dra7 checks
> there too to have kexec work on it? Basically we want to attempt to
> detect if there's a chance cpu1 is in WFI, and if I think the only
> optino is to reset it before bringing it up as otherwise outcome will
> be unpredictable.
> 

This patch seems stop the reset issue on my boards, so as long as it is
just a temporary workaround until we can fix the real issue (a core that
should be off going into omap_do_wfi() instead of parking), then this
patch works for me.

[...]

> +
> +	/* REVISIT: Anything to check for HS dra7? */
> +	if (soc_is_dra74x() && omap_secure_apis_support())
> +		return;

omap_secure_apis_support() only returns true when cpu_is_omap44xx() is
true, so this will never be true. Someday we may add the secure APIs to
secure DRA7xx devices, but I don't know of a good way to detect this
from kernel right now.

Andrew
