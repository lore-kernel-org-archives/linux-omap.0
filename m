From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH v5 1/5] omap3: pm: fix for twl4030 script load
Date: Tue, 11 May 2010 15:46:52 +0300
Message-ID: <20100511124652.GA4749@codecarver.research.nokia.com>
References: <1271677380-2095-1-git-send-email-leslyam@ti.com> <20100504062701.GA8686@besouro.research.nokia.com> <007201caeb5c$9ca7ed50$518918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52462 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447Ab0EKMrK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 08:47:10 -0400
Content-Disposition: inline
In-Reply-To: <007201caeb5c$9ca7ed50$518918ac@apr.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Lesly Arackal Manuel <leslyam@ti.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Hi,

> 
> Hi Eduardo,
> 
> The load_twl4030_script() is called from twl4030_power_init() which is again
> called from twl_probe(), and this is getting called before
> omap3_idle_init().
> 
> So the scripts are loaded before the cpuidle is initialized.
> Then I don't think the system will hit sys_off before loading the scripts.
> 
> Regards,
> Lesly
> 

Hi,

I agree that in our usecase the problem can probably never happen. But
what if NSLEEP2 would be controlled by some external component (Ie. not
OMAP) ? I don't think we can be sure that the sleep script will not be
executed while the wakeup script is not yet loaded (assuming they would
be loaded in the wrong order). Note that loading the script also sets
the address in the corresponding TWL4030 register. So I think this
safeguard is still useful.

Thanks,

Peter.
