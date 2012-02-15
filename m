From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] ARM: OMAP4: cminst: Add boot time __init function
 for cminst
Date: Wed, 15 Feb 2012 06:27:53 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317CF3B2@DBDE01.ent.ti.com>
References: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
	<1329233348-23356-2-git-send-email-hvaibhav@ti.com>
 <87bop1unln.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55144 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab2BOG2L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 01:28:11 -0500
In-Reply-To: <87bop1unln.fsf@macbook.be.48ers.dk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Feb 15, 2012 at 02:41:32, Peter Korsgaard wrote:
> >>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
>  Vaibhav> AM33xx CM module is closer to OMAP4 CM module, and
>  Vaibhav> in order to reuse cminst api's we have to address
>  Vaibhav> some of the differences like, base addresses and partitions.
>  Vaibhav> Unlike OMAP4 CM, AM33xx doesn't have any partitions and
>  Vaibhav> maintains only single partition.
> 
>  Vaibhav> So, in order to reuse the existing OMAP4 cminst code
>  Vaibhav> for AM33xx this patch adds,
> 
>  Vaibhav>   - Boot time __init function, to initialize _cm_bases
>  Vaibhav>     based on cpu_is_xxx
>  Vaibhav>   - Instead of maintaining phy addr for CM partition
>  Vaibhav>     in _cm_bases[] table and then changing it to virt addr,
>  Vaibhav>     directly maintain respective virt addr.
> 
>  Vaibhav> @@ -103,19 +106,19 @@ static bool _is_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
>  Vaibhav>  /* Read a register in a CM instance */
>  Vaibhav>  u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx)
>  Vaibhav>  {
>  Vaibhav> -	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
>  Vaibhav> +	BUG_ON(part >= max_cm_partitions ||
>  Vaibhav>  	       part == OMAP4430_INVALID_PRCM_PARTITION ||
> 
> How about dropping the OMAP4430_ prefix here as it's no longer 4430 specific?
> 
Peter,

You could be right here, from this patch perspective, this change doesn't make sense.

But at the first place I am quite not sure, why this has been named as
OMAP4430_? Vs some macros are named as OMAP4_.

So first we need to understand why it has been named this way,
may be "Paul Walmsley" can comment on this. He is original author of this 
file.

Thanks,
Vaibhav

> -- 
> Bye, Peter Korsgaard
> 

