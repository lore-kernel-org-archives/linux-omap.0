From: tony@atomide.com
Subject: Re: [PATCH 2/4] FB: sync with N800 tree (generic FB code)
Date: Tue, 6 Mar 2007 04:02:10 -0800
Message-ID: <20070306120209.GB366@atomide.com>
References: <20070305120950.GB4435@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070305120950.GB4435@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@solidboot.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Imre Deak <imre.deak@solidboot.com> [070305 04:11]:
> - dynamic relocation of FB mem to SRAM, SDRAM
> - support for per window resizing in window updates
> - fix locking in plane reconfiguration
> - extended capability query for separate plane / window attributes,
>   and supported color formats

Pushing your other FB patches to omap-drivers today.

Once your FB patches against mainline are ready, I'll switch omap-drivers
branch to use those.

Regards,

Tony
