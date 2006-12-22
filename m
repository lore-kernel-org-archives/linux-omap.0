From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in timer32k.c
Date: Fri, 22 Dec 2006 12:34:19 -0800
Message-ID: <20061222203419.GM2449@atomide.com>
References: <458BAE79.7020703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <458BAE79.7020703@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061222 02:13]:
> 
> ARM: OMAP: Fix warning in timer32k.c if CONFIG_NO_IDLE_HZ
> isn't set:
> 
> arch/arm/plat-omap/timer32k.c:221: warning:
> 'omap_32k_timer_handler' defined but not used

Pushing today.

Tony
