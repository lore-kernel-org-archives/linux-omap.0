From: Tony Lindgren <tony@atomide.com>
Subject: Re: OSK5912 cpu_is_omap5912() FALSE
Date: Thu, 2 Feb 2006 15:41:49 -0800
Message-ID: <20060202234149.GO15939@atomide.com>
References: <F0A81B25BD70E240B7E341C65A96C833031B6F75@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <F0A81B25BD70E240B7E341C65A96C833031B6F75@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Smith, Stephen" <smsmith@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Smith, Stephen <smsmith@ti.com> [060202 15:14]:
> OSK5912/Linux 2.6.13
> 
>  
> 
> There is a discrepancy in cpu.h and what my OSK5912 reflects.
> 
>  
> 
> cpu.h reflects:
> 
> IS_OMAP_TYPE(5912, 0x1611)
> 
>  
> 
> Here is my data from boot, which reflects the correct values:
> 
> OMAP_DIE_ID_0: 0xbfd20610
> 
> OMAP_DIE_ID_1: 0x8e059089 DIE_REV: 2
> 
> OMAP_PRODUCTION_ID_0: 0x00aaaafc
> 
> OMAP_PRODUCTION_ID_1: 0x00016cbe JTAG_ID: 0x6cbe
> 
> OMAP32_ID_0: 0x03320500
> 
> OMAP32_ID_1: 0x2b65f02f
> 
> JTAG_ID: 0xb65f DIE_REV: 2
> 
> OMAP162123 revision 2 handled as 16xx id: 8e059089bfd20610
> 
>  
> 
>  
> 
> Is arch-omap/cpu.h wrong, or is there something more here?  With
> 
> code as it was patched, cpu_is_omap5912() fails.  Sign of problem
> 
> is the inability to reboot the board (# reboot).  I can fix by
> 
> changing cpu.h to:
> 
>  
> 
> IS_OMAP_TYPE(5912, 0x1621)
> 
>  
> 
> I don't want to blindly change because I do not know history of OMAP5912
> 
> and it is possible some previous rev had id'ed as 1611.
> 
> It could also be fixed by adding another type check to arch_reset(), but
> 
> that may include 1621 types that do not require or want workaround.

We should really get rid of cpu_is_omap5912() and just use
cpu_is_omap16xx().

If 1710 is excluded, we should use something like:

(cpu_is_omap16xx() && !cpu_is_omap1710())

In some cases we may need to test for machine_is_omap_osk() instead.

Tony
