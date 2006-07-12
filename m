From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Build error with latest GIT tree
Date: Wed, 12 Jul 2006 07:06:54 +0200
Message-ID: <44B4836E.1080203@gmail.com>
References: <C51F43ABFC95844490F0529B60753BF4055F32C0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF4055F32C0@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Hunter, Jon" <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprooted.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hunter, Jon wrote:
> I did a diff between the clock.h file in the include/asm/arch/ directory
> and found the following differences between v2.6.17 and v2.6.17-rc6
> (which I belive is the latest);
> 
> --- include/asm/arch/clock.h    2006-07-11 10:45:46.000000000 -0500
> +++ ../linux-omap-2.6.git/include/asm/arch/clock.h      2006-07-10
> 16:34:40.000000000 -0500
> @@ -48,8 +48,6 @@
>  };
> 
>  extern unsigned int mpurate;
> -extern struct list_head clocks;
> -extern spinlock_t clockfw_lock;
> 
> I believe the removal of "clocks" variable is why the compiler is
> complaining below. Let me know if you have any thoughts.

For me, recent git compiles okay regarding this for OSK. 
Seems that I use

# CONFIG_OMAP_RESET_CLOCKS is not set

and therefore the failing part isn't used by me.

Kevin, any idea? Do we have to readd

extern struct list_head clocks;

if CONFIG_OMAP_RESET_CLOCKS is enabled?

Jon: Try to disable CONFIG_OMAP_RESET_CLOCKS for the moment.

Regards

Dirk

>>Is anyone seeing the following build error with the latest GIT tree?
>>Seemed similar to the following issue, but the exact error looks
>>different:
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-Ju
>>ne/007473.
>>html
>>
>>
>>CC      arch/arm/mach-omap1/clock.o
>>arch/arm/mach-omap1/clock.c: In function `omap1_late_clk_reset':
>>arch/arm/mach-omap1/clock.c:609: error: `clocks' undeclared 
>>(first use in this function)
>>arch/arm/mach-omap1/clock.c:609: error: (Each undeclared 
>>identifier is reported only once
>>arch/arm/mach-omap1/clock.c:609: error: for each function it appears
>>in.)
>>make[1]: *** [arch/arm/mach-omap1/clock.o] Error 1
>>make: *** [arch/arm/mach-omap1] Error 2
>>
>>Cheers,
>>Jon
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
