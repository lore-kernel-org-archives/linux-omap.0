From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods
 without sysc
Date: Tue, 13 Jan 2015 23:29:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501132324150.28034@utopia.booyaka.com>
References: <1418917790-1791-1-git-send-email-rogerq@ti.com> <5492F84E.7020706@ti.com> <alpine.DEB.2.02.1501020654050.27058@utopia.booyaka.com> <54AA4CD4.40105@ti.com> <alpine.DEB.2.02.1501060202540.28771@utopia.booyaka.com> <54AB9983.1040703@ti.com>
 <54AC1800.1020406@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54AC1800.1020406@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Roger Quadros <rogerq@ti.com>, tony@atomide.com, santosh.shilimkar@oracle.com, t-kristo@ti.com, nm@ti.com, nsekhar@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Suman,

thanks for pitching in on this!

On Tue, 6 Jan 2015, Suman Anna wrote:

> You have removed the return from the above block on failure. If any DT
> entry doesn't have the reg property, this will hang the kernel boot.
> Just remove the "reg" entry from any of the existing DT, and you will
> run into the issue, this is what 6423d6df1440 ("ARM: OMAP2+: hwmod:
> check for module address space during init") fixed. 

Seems like that's the problem that we need to track down, then.  If a 
hwmod has no MPU-accessible registers, it should still be possible to 
init the clocks for the device, etc. ...

> Also, are you sure you want to turn the WARN into a pr_debug, it won't 
> even show during the kernel boot log if the reg base is missing.

No, I'm not sure :-)  I guess it depends how many hwmods we'll have with 
no MPU-accessible registers.  We don't seem to have address ranges for the 
interconnects defined; we could fix that fairly easily. 


- Paul
