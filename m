From: Tony Lindgren <tony@atomide.com>
Subject: Re: RMKs comments on latest OMAP upstream patches
Date: Thu, 20 Sep 2007 18:59:37 -0700
Message-ID: <20070921015935.GA26096@atomide.com>
References: <46F29DB0.9060203@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46F29DB0.9060203@googlemail.com>
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
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070920 09:21]:
>
> Just fyi: Tony (thanks!) sent a OMAP1 and a OMAP2 patch to RMK for review 
> and upstream merge. Regarding OMAP1, there are some comments from RMK, 
> nothing yet for OMAP2:
>
> OMAP1: 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4570/1
>
> OMAP2: 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4571/1
>
> While -rc7 is out [1] and we are short before final 2.6.23 release with 
> merge window opening, we have to see if our patches will be merged.

Yeh, I've removed the clock init RMK does not like, and will change them
to use just struct clk *clk instead on the fbdevel list.

Regards,

Tony


> [1] http://lwn.net/Articles/250570/
