From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: check for module address space during
 init
Date: Thu, 3 Oct 2013 13:05:30 -0400
Message-ID: <524DA3DA.5000507@ti.com>
References: <1380819546-53631-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44993 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754121Ab3JCRFg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Oct 2013 13:05:36 -0400
In-Reply-To: <1380819546-53631-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Afzal Mohammed <afzal@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, Nishant Menon <nm@ti.com>, linux-omap@vger.kernel.org

On Thursday 03 October 2013 12:59 PM, Suman Anna wrote:
> The hwmod init sequence involves initializing and idling all the
> hwmods during bootup. If a module class has sysconfig, the init
> sequence utilizes the module register base for performing any
> sysc configuration.
> 
> The module address space is being removed from hwmod database and
> retrieved from the <reg> property of the corresponding DT node.
> If a hwmod does not have its corresponding DT node defined and the
> memory address space is not defined in the corresponding
> omap_hwmod_ocp_if, then the module register target address space
> would be NULL and any sysc programming would result in a NULL
> pointer dereference and a kernel boot hang.
> 
> Handle this scenario by checking for a valid module address space
> during the _init of each hwmod, and leaving it in the registered
> state if no module register address base is defined in either of
> the hwmod data or the DT data.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> This patch helps break the dependencies between hwmod entries and
> corresponding DT entries (especially on OMAP5, where most of the
> address spaces are already cleaned up and the current data files
> have minimal entries) and fixes any boot issues due to missing
> addresses. See for reference,
> http://marc.info/?t=138005421400003&r=1&w=2
> 
> Tested on BeagleXM, Panda4, BeagleBone Black and Panda5 using
> Tero's v7 clk DT patches and Benoit's for-3.13/dts on top of
> 3.12-rc3
> 
Good to break that dts/hwmod dependency.
FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


