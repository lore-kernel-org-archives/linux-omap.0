From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 0/5] SRAM patcher: patch register addresses in SRAM
	code at runtime
Date: Wed, 14 Nov 2007 09:38:26 -0800
Message-ID: <1195061906.15127.51.camel@vence.hilman.org>
References: <20071114083010.938764990@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20071114083010.938764990@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


On Wed, 2007-11-14 at 01:30 -0700, Paul Walmsley wrote:
> Several SRAM-based assembly-language routines in the Linux OMAP kernel
> use hardcoded virtual addresses to access system registers.  These
> addresses were defined at compile-time by the preprocessor, since the
> same registers often appeared at different virtual addresses
> depending upon the target OMAP architecture.  Hardcoding the addresses
> is efficient and convenient to implement; but precludes a single kernel
> binary image from supporting multiple OMAP architectures.
> 
> This patches implement a different approach.  They patch in the
> correct register addresses at runtime into the SRAM, just after the
> code is copied there.  While the current code simply writes in the
> preprocessor-defined address bases, a forthcoming patch series uses
> this code to write runtime-computed address bases.
> 
> The code that does the patching is quite paranoid by default, and will
> refuse to overwrite any address that does not contain a magic number,
> SRAM_VA_MAGIC.  It also contains debugging printks which can be
> activated by defining the DEBUG symbol in sram.c and compiling with
> CONFIG_DEBUG_LL enabled.
> 
> Boot-tested on N800 and 3430SDP.  If someone out there with a 2430SDP
> can give these a whirl, that would be appreciated.  Comments welcome,

Looks good for 2430DSP.

I tested suspend, and sleep-when-idle (both of which can hit full
retention BTW.)

Kevin
