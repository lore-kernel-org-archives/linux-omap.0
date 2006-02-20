From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix error in omap_ts.c
Date: Mon, 20 Feb 2006 14:44:04 -0800
Message-ID: <20060220224404.GE30248@atomide.com>
References: <43F5F298.3050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43F5F298.3050505@gmail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [060217 08:04]:
> 
> ARM: OMAP: Add missing '=' in omap_ts.c as proposed by
> Andrzej Zaborowski.
> 
> Fix error
> 
> CC      drivers/input/touchscreen/omap/omap_ts.o
> drivers/input/touchscreen/omap/omap_ts.c:230: error: syntax
> error
> before '{' token
> drivers/input/touchscreen/omap/omap_ts.c:233: error: syntax
> error
> before '}' token

Pushing today, thanks.

Tony
