From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 00/32] Convert ARM to generic irq subsystem
Date: Fri, 28 Apr 2006 15:07:53 -0700
Message-ID: <44529239.2060409@mvista.com>
References: <20060407095850.690110000@localhost.localdomain>
	<20060426230543.GA28908@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060426230543.GA28908@flint.arm.linux.org.uk>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Thomas Gleixner <tglx@linutronix.de>, LAK <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> On Fri, Apr 07, 2006 at 07:45:33PM -0000, Thomas Gleixner wrote:
>> Our patchset, which converts ARM to the generic irq subsystem has 
>> reached a stable state and we ask for inclusion.
> 
> We require people's help on this list concerning these patches.  The
> latest versions can be found at:
> 
>   http://www.tglx.de/projects/armirq/
>   http://www.tglx.de/projects/armirq/2.6.17-rc1/patch-2.6.17-rc1-armirq5.patches.tar.bz2
> 
> (please check for later versions! - note though that www.tglx.de's isp is
> having issues atm.)
> 
> Basically, there's two ways that we can merge these patches:
> 

I am testing these on OMAP.

First pass shows that smc91x interrupts are getting lost.  They are GPIO 
interrupts on most OMAP platforms and pass through a chained gpio handler.  I'm 
still investigating, but I'm guessing it as something to do with SA_TRIGGER_* 
flags used in the smc91x driver for OMAP.

I don't see handling of SA_TRIGGER_* in the generic layer.  Is there a new way 
of handling these?

Kevin
