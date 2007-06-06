From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: init section mismatch for omap2/timer-gp
Date: Tue, 05 Jun 2007 20:43:57 -0500
Message-ID: <4666115D.2010103@gmail.com>
References: <11810916331121-git-send-email-khilman@mvista.com>
	<11810916332938-git-send-email-khilman@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11810916332938-git-send-email-khilman@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kevin,
Kevin Hilman stated on 6/5/2007 8:00 PM:
>  
> -struct sys_timer omap_timer = {
> +struct sys_timer omap_timer __initdata = {
>  	.init	= omap2_gp_timer_init,
>  };
>   
Patch attempted here:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010075.html

Rejected here:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010097.html

Regards,
Nishanth Menon
