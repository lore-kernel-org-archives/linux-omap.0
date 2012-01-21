From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sat, 21 Jan 2012 00:39:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201210038460.28153@utopia.booyaka.com>
References: <1327055619.1921.57.camel@deskari> <CAAL8m4xNj=-=tz7Fkv_MQzvQy5iNj9n10=00KAi0=ixtQ1GVVA@mail.gmail.com> <1327057644.1921.59.camel@deskari> <CAAL8m4zN7iRAWcV32+z+MrFcgaOnk_r-npA9uLLS+S7w1O2LYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50453 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2AUHjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 02:39:04 -0500
In-Reply-To: <CAAL8m4zN7iRAWcV32+z+MrFcgaOnk_r-npA9uLLS+S7w1O2LYg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, Rajendra Nayak <rnayak@ti.com>

On Fri, 20 Jan 2012, Govindraj wrote:

> 3.3-rc1 has uart runtime patches merged we have removed uart dependency
> for system to enter low powers states and used pm_qos calls,
> but pm_qos api's seem do get activated only by enabling  config_cpu_idle.
> 
> Question to kevin/Paul,
> 
> Shouldn't system be doing wfi if cpu_idle is not enabled ?
> 
> since we are mapping omap3_pm_idle to pm_idle thread
> system enters low power states even if config_cpu_idle is not enabled.
> Is this expected behavior?

Yes.


- Paul
