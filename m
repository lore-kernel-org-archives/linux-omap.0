From: tony@atomide.com
Subject: Re: [PATCH 1/4] FB: sync with N800 tree (support for dynamic SRAM
	allocations)
Date: Tue, 6 Mar 2007 04:01:08 -0800
Message-ID: <20070306120106.GA366@atomide.com>
References: <20070305120706.GA4435@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070305120706.GA4435@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@solidboot.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Imre Deak <imre.deak@solidboot.com> [070305 04:08]:
> - in addition to fixed FB regions - as passed by the bootloader -
>   allow dynamic allocations
> - do some more checking against overlapping / reserved regions
> - move the FB specific parts out from sram.c to fb.c

Pushing to omap-upstream today.

Tony
