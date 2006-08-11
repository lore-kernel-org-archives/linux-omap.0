From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Remove duplicate pm.c
Date: Fri, 11 Aug 2006 13:00:19 +0300
Message-ID: <20060811100018.GE6720@atomide.com>
References: <fb249edb0608092342n797e7532na3d5fbf9cdcda028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0608092342n797e7532na3d5fbf9cdcda028@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060810 09:43]:
> [I can see arch/arm/plat-omap/pm.c has been removed together with
> sleep.S in the history, but it's there again, and sleep.S isn't. How
> does this work?]

It seems that we can lose some commits during merges :( I'll try to track
it down next time I do a merge from mainline.
 
> Remove arch/arm/plat-omap/pm.c because it now sits in arch/arm/mach-omap1 
> and 2.

Pushing today.

Tony
