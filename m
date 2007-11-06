From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] include/asm-arm/arch-omap/omap24xx.h
Date: Tue, 6 Nov 2007 03:23:09 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711060318490.25907@utopia.booyaka.com>
References: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>
	<471F868A.3060106@googlemail.com> <20071025053143.222542615@pwsan.com>
	<4720B62A.1010406@googlemail.com>
	<Pine.LNX.4.64.0710250955270.25986@utopia.booyaka.com>
	<20071031152230.GP32547@atomide.com> <20071101082943.GA780@atomide.com>
	<Pine.LNX.4.64.0711050052050.7016@utopia.booyaka.com>
	<472F7031.3000308@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <472F7031.3000308@googlemail.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Dirk,

On Mon, 5 Nov 2007, Dirk Behme wrote:

> Until we have real fix like above: Instead of now trying to cover all
> situations where OMAP2_CTRL_BASE is undefined or redefinded (maybe there are
> some more?), I wonder why not simply make it self-dependent?
> 
> #if !defined(OMAP2_CTRL_BASE)
> /* FIXME: These will go away soon */
> #define OMAP2_CTRL_BASE		L4_24XX_BASE
> #endif

I don't think that will work.  Consider the case of a file that 
includes both omap24xx.h and omap34xx.h during a 3430 build.  When 
omap24xx.h is processed, OMAP2_CTRL_BASE will be defined by the above 
code; then omap34xx.h will redefine it, causing the same warning.


- Paul
