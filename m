From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap2: use symbolic constant to mark parent-controlled clocks
	in clock.[ch]
Date: Fri, 4 May 2007 09:19:31 -0700
Message-ID: <20070504161930.GC12331@atomide.com>
References: <Pine.LNX.4.64.0705031206440.19145@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705031206440.19145@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@booyaka.com> [070503 11:08]:
> 
> The current OMAP2 clock management code uses a magic number, 0xff, to 
> indicate that the clock's parent will handle enabling and disabling the 
> clock.  Move the magic number into a symbolic constant for readability.

Thanks, pushing the unwrapped version of this today.

Tony
