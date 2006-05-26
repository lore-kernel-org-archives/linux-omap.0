From: Tony Lindgren <tony@atomide.com>
Subject: Re: Kernel 2.6.16 hangs after start booting with U-Boot 1.1.2
Date: Fri, 26 May 2006 15:08:54 -0700
Message-ID: <20060526220853.GH4132@atomide.com>
References: <922740597@web.de> <44746F4C.60500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <44746F4C.60500@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Martin Margraf <m_margraf@web.de>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [060524 07:44]:
> Martin Margraf wrote:
> >my problem is that after updating u-boot from 1.1.1 to 1.1.2 and after 
> >patching /arch/arm/boot/compressed/makefilfe and head-omap.S
> >the kernel is hanging up at start. i use the latest kernel (2.6.16.18) and 
> >patched it with the 2.6.16-omap1 patch.
> 
> You don't tell us which board you use, which patches you 
> applied to makefile and head-omap.S and where kernel hangs.
> 
> Try to enable
> 
> Kernel hacking -> Kernel debugging -> Kernel low-level 
> debugging functions
> 
> for debugging.
> 
> Often made mistake are wrong parameters passed from u-boot 
> to kernel (e.g. board ID) after u-boot update.
> 
> Why do you update to u-boot 1.1.2 and not latest one (1.1.4)?

Is this perhaps the memory timing issue also?

Tony
