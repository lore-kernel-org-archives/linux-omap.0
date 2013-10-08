From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: check for module address space during
 init
Date: Tue, 8 Oct 2013 16:44:57 -0500
Message-ID: <52547CD9.6060203@ti.com>
References: <1380819546-53631-1-git-send-email-s-anna@ti.com> <20131008180936.GE8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42483 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab3JHVpx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 17:45:53 -0400
In-Reply-To: <20131008180936.GE8313@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Afzal Mohammed <afzal@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Nishant Menon <nm@ti.com>, linux-omap@vger.kernel.org

Tony,

On 10/08/2013 01:09 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [131003 10:07]:
>> The hwmod init sequence involves initializing and idling all the
>> hwmods during bootup. If a module class has sysconfig, the init
>> sequence utilizes the module register base for performing any
>> sysc configuration.
>>
>> The module address space is being removed from hwmod database and
>> retrieved from the <reg> property of the corresponding DT node.
>> If a hwmod does not have its corresponding DT node defined and the
>> memory address space is not defined in the corresponding
>> omap_hwmod_ocp_if, then the module register target address space
>> would be NULL and any sysc programming would result in a NULL
>> pointer dereference and a kernel boot hang.
> 
> Hmm so is this needed as a fix for the -rcy cycle?

This is a dependency for a successful OMAP5 boot with Tero's clock
patches (just the clock patches won't help), but those are not in
3.12-rcy anyway. I will leave it upto you and Paul, it will be one less
patch that people need to worry about for booting OMAP5 if it can make
the -rcy cycle.

regards
Suman

>  
> Other than that looks OK to me, Paul should queue or ack this one:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

