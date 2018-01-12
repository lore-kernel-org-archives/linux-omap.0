From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH, v3] arm: omap2: timer: fix a kmemleak caused in
 omap_get_timer_dt
Date: Fri, 12 Jan 2018 13:08:44 -0800
Message-ID: <20180112210844.GF4821@atomide.com>
References: <1515646483-24199-1-git-send-email-qi.hou@windriver.com>
 <7dd12934-862c-c7ad-5f43-43e4c6b08199@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7dd12934-862c-c7ad-5f43-43e4c6b08199@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Qi Hou <qi.hou@windriver.com>, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180112 20:36]:
> Hi
> 
> On 01/10/2018 10:54 PM, Qi Hou wrote:
> > When more than one GP timers are used as kernel system timers and the
> > corresponding nodes in device-tree are marked with the same "disabled"
> > property, then the "attr" field of the property will be initialized
> > more than once as the property being added to sys file system via
> > __of_add_property_sysfs().
> > 
> > In __of_add_property_sysfs(), the "name" field of pp->attr.attr is set
> > directly to the return value of safe_name(), without taking care of
> > whether it's already a valid pointer to a memory block. If it is, its
> > old value will always be overwritten by the new one and the memory block
> > allocated before will a "ghost", then a kmemleak happened.
> > 
> > That the same "disabled" property being added to different nodes of device
> > tree would cause that kind of kmemleak overhead, at leat once.
> > 
> > To fix it, allocate the property dynamically, and delete static one.
> 
> Does it in sync with Keerthy's work [1]

First fixes, then new stuff! Keerthy's work will have to
wait for v4.17, we want that series sitting in Linux next
for several weeks.

Regards,

Tony

> [1] https://www.spinics.net/lists/linux-omap/msg141100.html
