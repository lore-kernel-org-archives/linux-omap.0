From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v5 1/5] omap3: pm: fix for twl4030 script load
Date: Thu, 13 May 2010 15:13:59 +0530
Message-ID: <013f01caf280$d1fec1b0$ba8818ac@apr.dhcp.ti.com>
References: <1271677380-2095-1-git-send-email-leslyam@ti.com> <20100504062701.GA8686@besouro.research.nokia.com> <007201caeb5c$9ca7ed50$518918ac@apr.dhcp.ti.com> <20100511124652.GA4749@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55971 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691Ab0EMJoM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 05:44:12 -0400
In-Reply-To: <20100511124652.GA4749@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>
Cc: "'Valentin Eduardo (Nokia-D/Helsinki)'" <eduardo.valentin@nokia.com>, linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>


> -----Original Message-----
> From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com]
> Sent: Tuesday, May 11, 2010 6:17 PM
> To: ext Lesly Arackal Manuel
> Cc: Valentin Eduardo (Nokia-D/Helsinki); linux-omap@vger.kernel.org;
> 'Lesly A M'; 'Nishanth Menon'; 'David Derrick'; 'Samuel Ortiz'
> Subject: Re: [PATCH v5 1/5] omap3: pm: fix for twl4030 script load
> 
> Hi,
> 
> >
> > Hi Eduardo,
> >
> > The load_twl4030_script() is called from twl4030_power_init() which is
> again
> > called from twl_probe(), and this is getting called before
> > omap3_idle_init().
> >
> > So the scripts are loaded before the cpuidle is initialized.
> > Then I don't think the system will hit sys_off before loading the
> scripts.
> >
> > Regards,
> > Lesly
> >
> 
> Hi,
> 
> I agree that in our usecase the problem can probably never happen. But
> what if NSLEEP2 would be controlled by some external component (Ie. not
> OMAP) ? I don't think we can be sure that the sleep script will not be
> executed while the wakeup script is not yet loaded (assuming they would
> be loaded in the wrong order). Note that loading the script also sets
> the address in the corresponding TWL4030 register. So I think this
> safeguard is still useful.
> 
> Thanks,
> Peter.

Hi Peter,

 I am not very much sure whether the MODEM(or any co processor) connected to
NSLEEP2 of TRITON will assert the sleep signal, before OMAP3430(AP) boots
up.

 So if this is confirmed, it will be better to check the order while
populating the scripts.

Thanks & Regards,
Lesly A M



