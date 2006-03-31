From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] fix MMC response types
Date: Fri, 31 Mar 2006 20:35:49 +0300
Message-ID: <442D6875.20204@cc.jyu.fi>
References: <fb249edb0603241237l5854cc04k@mail.gmail.com>		<4427DEA0.6050804@indt.org.br>	<fb249edb0603271204o1d8df4oe636c1181362d740@mail.gmail.com>	<4429A3A6.5000503@indt.org.br>
	<442B1840.6060801@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <442B1840.6060801@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>
>Hopefully this patch is not needed anymore after your updates, but here
>it is anyway just in case that somebody finds it usefull.
>  
>
Btw, I tested this more and found out that the only thing really needed
to get h6300
to mount SD in addition of MMC card during the boot was this one.
(That's on top of the latest omap-git version)

diff -Naur orig/mmc.c fixed/mmc.c
--- orig/mmc.c	2006-03-18 10:22:19.000000000 +0200
+++ fixed/mmc.c	2006-03-18 10:30:32.000000000 +0200
@@ -964,7 +964,7 @@
 		mmc_decode_scr(card);
 	}
 
-	mmc_deselect_cards(host);
+	//mmc_deselect_cards(host);
 }
