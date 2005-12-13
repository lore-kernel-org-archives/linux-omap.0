From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: OMAP touchscreen timer BUG
Date: Tue, 13 Dec 2005 07:39:11 +0100
Message-ID: <439E6C8F.4040405@de.bosch.com>
References: <20051213022905.GA27130@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051213022905.GA27130@slurryseal.ddns.mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Todd Poynor wrote:

> kernel BUG at include/linux/timer.h:83!
> [<c002ac60>] (__bug+0x0/0x58) from [<c01a3fbc>] (omap_ts_handler+0x60/0x78)
> [<c01a3f5c>] (omap_ts_handler+0x0/0x78) from [<c00269fc>] (__do_irq+0x4c/0x8c)
> 
> which is:
> 
> static inline void add_timer(struct timer_list *timer)
> {
>         BUG_ON(timer_pending(timer));
>         __mod_timer(timer, timer->expires);

Because Tonys vacation, we have some pending patches on the list. I 
fixed this already in

http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005837.html

using an additional del_timer().

I will try to send a pending patches list next days.

Dirk
