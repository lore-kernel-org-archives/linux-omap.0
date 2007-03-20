From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Fix warnings in devices.c for 2430sdp config
Date: Tue, 20 Mar 2007 12:05:47 -0400
Message-ID: <20070320160540.GB8596@atomide.com>
References: <45FEC9CB.9010602@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45FEC9CB.9010602@googlemail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [070319 13:41]:
> 
> Fix warnings
> 
> arch/arm/plat-omap/devices.c:159: warning: 'omap_init_kp' 
> defined but not used
> arch/arm/plat-omap/devices.c:282: warning: 'omap_init_mmc' 
> defined but not used
> arch/arm/plat-omap/devices.c:436: warning: 'omap_init_wdt' 
> defined but not used
> arch/arm/plat-omap/devices.c:469: warning: 'omap_init_rng' 
> defined but not used

AFAIK some these devices are on 2430, so maybe somebody could
patch them to work instead? The DSP is different from 2420 though.

Tony
