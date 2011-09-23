From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Thu, 22 Sep 2011 18:16:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109221814500.10719@utopia.booyaka.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com> <1316691479-1849-2-git-send-email-keshava_mgowda@ti.com> <alpine.DEB.2.00.1109221213500.10719@utopia.booyaka.com> <4E7B8C68.7020407@ti.com>
 <alpine.DEB.2.00.1109221524560.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1109221524560.10719@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi

On Thu, 22 Sep 2011, Paul Walmsley wrote:

> On Thu, 22 Sep 2011, Cousson, Benoit wrote:
> 
> > ADDR_TYPE_RT is mainly use for sysconfig access inside hwmod core today, so
> > why should we use it in this case?
> 
> Just for consistency, since the flag isn't defined to be 
> SYSCONFIG-specific.
> 
> That way, if there's another need -- other than SYSCONFIG access -- to 
> identify the chunk of address space that's used for register access, we 
> won't have to dig through and possibly repatch the hwmod data, just 
> because some people didn't want to follow the rule.
> 
> If the flag was simply defined to be SYSCONFIG-specific, then you're 
> right, it wouldn't be needed.
> 
> > To be honest, I've been confused with that flag for some time :-)
> >  * ADDR_TYPE_RT: Address space contains module register target data.
> > Maybe that's my English, but what does "register target data" mean exactly?
> 
> The name comes from the L3 section of the 34xx TRM - see for example 
> section 9.1.1 "Terminology" of the rev ZR TRM.  The L3 has several address 
> space sections, and whoever wrote that text -- Sonics? -- called the one 
> with the L3's own internal registers the "register target."  And I was 
> looking for a name that I did not have to make up, so I personally 
> wouldn't have to defend the name ;-)
> 
> > What was the intent? Providing a way to identify some register vs memory
> > space?
> 
> As you suggest, the original impetus for the flag was to identify which 
> chunk of address space needs to be mapped by the hwmod code for SYSCONFIG 
> accesses to work.  On current OMAPs, this seems to be the same thing as 
> identifying the IP block's primary register area for every module with 
> SYS* and REVISION registers.  And I probably thought at the time that 
> specifying the IP block's main register mapping seemed more useful and 
> generally applicable than designating where the SYSCONFIG register was.  
> Hence the current definition.

Hopefully this should go without saying, but if you think there's a good 
rationale for renaming this flag to indicate that an address space 
contains the SYSCONFIG registers, or maybe just changing the 
documentation for the flag to indicate that, that's fine with me, just 
send a patch.


- Paul
