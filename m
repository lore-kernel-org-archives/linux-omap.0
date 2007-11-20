From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 0/4] Runtime constants: define (some) OMAP address bases
 at	runtime rather than compile time for multiboot
Date: Tue, 20 Nov 2007 07:24:48 +0100
Message-ID: <47427DB0.8020306@googlemail.com>
References: <20071116232159.713389488@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071116232159.713389488@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Paul Walmsley wrote:
> The OMAP2/3 kernel builds define several preprocessor macros for
> module base virtual addresses (e.g., OMAP2_CTRL_BASE).  These macros
> are substituted with virtual addresses at compile-time, depending on
> what OMAP architecture the kernel is built for.  This technique is
> simple and works well for single-OMAP kernels, but cannot be used to
> build a multi-OMAP kernel.
> 
> So, convert the users of these defines to use runtime-computed global
> variables where possible.  Where not possible (e.g., in static initializers), 
> use chip-specific preprocessor macros.  The global variables are set up
> early in the board-*.c files in the map_io() code, before almost everything 
> else.
> 
> This series must be applied after the SRAM patcher series posted earlier
> this week, since it relies on that code to set up register addresses in
> the assembly-language code at runtime.
> 
> This series converts SDRC, SMS, and System Control Module accesses.  
> Forthcoming patch series will convert PRCM and 32K sync timer register
> access.
> 
> Boot-tested on N800 and 3430SDP.  If someone out there could test on 2430SDP,
> that would be much appreciated.  Some day I'll get my hands on a  2430SDP :-) 
> 
> Comments welcome,

Patch 1/4 and 3/4 of this series still apply, but 2/4 and 4/4 have 
rejects. Could you check?

Many thanks

Dirk
