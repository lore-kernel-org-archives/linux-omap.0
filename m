From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: Pending patches mostly pushed, please check
Date: Tue, 03 Jan 2006 16:25:41 -0800
Message-ID: <43BB1605.9070903@mvista.com>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
	<20060103191356.GR6034@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060103191356.GR6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:

>> 9) LDM wakeup flags for OMAP keypad
>> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005897.html
> 
> Let's think about this one a bit more. Maybe we should have u32 device_wakeup in
> pm.c, and then various drivers would mask it with OMAP_WAKEUP_KEYPAD etc?
> 
> Or maybe device_init_wakeup() should register a callback function in the driver,
> and them pm.c just calls all registered wakeup callback functions? That would
> move the enable/disable code to drivers.

Agreed, I should have labeled this patch as at an RFC stage.  It's the 
first attempt I'm aware of to apply the wakeup flags stuff begun for 
PCI/USB to an embedded SoC, and was intended to start a discussion on 
the above sorts of issues, which should also occur on 
linux-pm@lists.osdl.org (and other embedded-oriented wakeup patches are 
being floated there as well).  It would be nice to move the wakeup 
enable code to drivers, but with the per-core keypad IRQ assignments, 
the need to enable level-2 IRQs, etc., not sure if a platform core file 
ends up being more suitable, don't have a strong opinion myself so far.

On a related note, if anybody knows how to tell what source woke up an 
OMAP from deep/big sleep I'd appreciate hearing about it.  I haven't 
found a register devoted to it, and keypad wakeup on my H3 seemed to 
show a pending Level-2 interrupt in the level-1 ITR, but the level-2 
ITRs all read zero (reading prior to enabling interrupts upon deep sleep 
resume).  Thanks,


-- 
Todd
