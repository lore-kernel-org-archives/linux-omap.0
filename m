From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] ARM: OMAP: Add clocksource driver for OMAP
Date: Mon, 13 Nov 2006 11:04:58 -0800
Message-ID: <4558C1DA.6050105@mvista.com>
References: <455755DB.1040308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <455755DB.1040308@gmail.com>
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

Dirk Behme wrote:
> 
> Add clocksource driver for OMAP.
> 
> This is an update of
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1
> 
> from Daniel Walker and Kevin Hilman.
> 
> Changes:
> 
> - Apply cleanly to recent git (pt_regs change)
> - Move clocksource init to extra function. Can be called later by 
> clocksource subsystem
> - Remove warning
> arch/arm/plat-omap/timer32k.c:216: warning: 'omap_32k_timer_handler' 
> defined but not used
> if CONFIG_NO_IDLE_HZ isn't set.
> - Minor cleanups
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

Acked-by: Kevin Hilman <khilman@mvista.com>
