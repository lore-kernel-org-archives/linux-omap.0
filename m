From: Arnold <abo_gwapo@yahoo.com>
Subject: NETDEV WATCHDOG
Date: Tue, 1 Aug 2006 18:59:54 -0700 (PDT)
Message-ID: <20060802015954.81185.qmail@web55808.mail.re3.yahoo.com>
References: <44CF831E.5000403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44CF831E.5000403@gmail.com>
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

> P.S.: Ethernet interrupt is connected to GPIO 0 of
> bank 0. 
> So the NETDEV WATCHDOG stuff may come either because
> you 
> accidently touched anything what is necessary for
> proper 
> ethernet interrupt. Or the GPIO interrupt you are
> dealing 
> with is coming so often that there isn't enough time
> for 
> ethernet irq. 

This problem occurs only if I stop the program. Which
calls the omap_free_gpio. Does freeing the gpio pin be
the cause of the problem?

Thanks,
OJ

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
