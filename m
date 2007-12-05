From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] 3430 clock: minor cleanup patches
Date: Wed, 5 Dec 2007 14:41:14 -0800
Message-ID: <20071205224113.GZ4105@atomide.com>
References: <20071204092605.831497615@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071204092605.831497615@pwsan.com>
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

* Paul Walmsley <paul@pwsan.com> [071204 01:31]:
> Hello,
> 
> These patches clean up a few minor issues with the OMAP3430 clock
> framework.  They:
> 
> - ensure that the System Control Module is enabled at clock framework init;
> 
> - combine some redundant clksel_rate structures;
> 
> - add the ICR clock, present on both 3430ES versions in chassis mode; and
> 
> - resolve the "Enable for xxx without enable code" warnings that
>   appear in 3430 bootlog.
> 
> 
> Boot-tested on 3430ES1 SDP.  Comments welcome.

Pushing today.

Tony
