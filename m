From: David Brownell <david-b@pacbell.net>
Subject: Re: Question About __REG32 marco
Date: Tue, 20 Nov 2007 13:26:05 -0800
Message-ID: <200711201326.06148.david-b@pacbell.net>
References: <005c01c82b61$ac9f1cf0$16110a0a@LongCheer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <005c01c82b61$ac9f1cf0$16110a0a@LongCheer.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: colorant <colorant@163.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 November 2007, colorant wrote:
> 
>     1:
>     Why this macro need to be defined in this way ?  Why borther to use an array ?
>     Can't we just use something like :
> 
>     *(volatile u32 *)(vaddr&~0x3) to get the value from vaddr with word align ?

It generalizes __REG2() from arch-pxa/hardware.h ... where,
as the comment notes, GCC would otherwise be incapable of
generating decent code.  It's possible GCC code generation
has gotten smarter since then.

Note that such macros are supposed to be used only with
constant addresses, so code can treat registers as if they
were global variables.  Some people dislike that style;
others find it more understandable than __raw_writel()
style accessors.

When it works right, driver code will have a register with
the base address of a controller, and all accesses to that
controller will use single word load/store instructions which
embed the offsets of the various registers being accessed
against that base register.

The main alternative addressing styles were notably larger
(I recall observing 1-2 KBytes per driver) and slower.


>     2:
>     Why this offset array need to be 4096 in size ? shouldn't it be 1024 ?
>     since it already point to a u32 value. and the >>2 make the macro never
>     got chance to reach a index great than 1024 !  

Look at the ARM instructions that are used.  The address
range may be 4KBytes, but the values are 4 bytes each.
So the range of their indices is just 1K.  (As implied
by the comments adjacent to those macro definitions, which
point out the use of LDR/STR for 8 and 32 bit values...)

That's the case for 32 bit values.  For other value sizes,
the logic is necessarily a bit different.

- Dave
