From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap2 clock: create clock24xx.[ch] in preparation
	for 3430 clock code
Date: Mon, 17 Sep 2007 11:16:06 -0700
Message-ID: <20070917181605.GC21226@atomide.com>
References: <20070912060141.645853958@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070912060141.645853958@pwsan.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [070912 01:40]:
> Hello,
> 
> this short patch series separates OMAP24xx clock definitions and code
> from common clock code and headers.  It's in preparation for OMAP3430
> clock definitions and code.
> 
> All this happens in patches 2 and 3 of this series.  The remaining
> patch 1 moves some SDRC-related defines from clock.h into sdrc.h where
> they belong.
> 
> The diffstat looks big, but the patches are mostly just cut and paste,
> with a few minor changes to expose common functions to the linker, and
> to satisfy checkpatch (at least somewhat).
> 
> Review and comments are appreciated, as always.

Pushing this series today.

Tony
