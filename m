From: Tony Lindgren <tony@atomide.com>
Subject: Re: old gpmc.h
Date: Thu, 10 Aug 2006 12:54:02 +0300
Message-ID: <20060810095401.GD30195@atomide.com>
References: <20060808103503.98907.qmail@web37901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060808103503.98907.qmail@web37901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060808 13:35]:
> Tony,
> 
> It seems that gpmc.h is not updated after Imre patch about dynamic
> allocator for GPMC. It gives me following error for h4 build.
> 
> arch/arm/mach-omap2/built-in.o(.init.text+0xae4): In function `$a':
> : undefined reference to `gpmc_cs_request'
> arch/arm/mach-omap2/built-in.o(.init.text+0xb48): In function `$a':
> : undefined reference to `gpmc_cs_free'
> arch/arm/mach-omap2/built-in.o(.init.text+0xb68): In function `$a':
> : undefined reference to `gpmc_cs_request'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Please update gpmc.h as per Imre's patch. Thanx.

Weird looks like some merges from 2.6.17-omap2 did not happen. It is
there as a7abfb3157101ee90f45e261c64850c980d1b6dc, but not in the
current head. There's probably other stuff unmerged as well then.
I'll try to fix it.

Tony
