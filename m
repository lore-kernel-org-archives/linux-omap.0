From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 0/5] [RFC] MMC handle mutiple slots by external
	transceiver
Date: Mon, 20 Mar 2006 06:43:25 -0800
Message-ID: <20060320144324.GC4980@atomide.com>
References: <20060308102705.c8713048.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060308102705.c8713048.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [060308 00:31]:
> Hello,
> 
> This patch series is intended basically to make MMC handle multiple bus(slots)
> when it uses an external transceiver. And this also can handle multiple
> SD cards at the same time. Basic idea is to deal with each slot independently
> during card detection phase until RCA number is assigned to each card, 
> because an external transceiver can deal each slot separately(independently).
> After RCA number is assigned(after card detection), we can access a specified
> card which we want to use by choosing RCA number.
> 
> Currently most of things is being handled by "drivers/mmc/omap.c" in order
> to keep current MMC common framework in "drivers/mmc/mmc.c" as it is. But 
> I think that there might be an another alternative implementation to change
> MMC common framework itself to handle multiple bus with an external 
> transceiver. So I would like to get some comments/feedbacks about this issue.
> 
> This patch series include 5 patches and 
> the main one is:
> 
> 	[patch 2/5] MMC MULTIPLE SLOT SUPPORT BASE
> 
> The others are small bugfixes and supplement ones.

Let's push these and once we have the Carlos' version of the MMC driver
integrated into the mainline kernel we start merging in the omap tree.
We probably will want to keep the existing MMC driver around for a
little while until everything is merged.

Tony
