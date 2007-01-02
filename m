From: tony@atomide.com
Subject: Re: 2.6.19 + omap patch on the OSK
Date: Tue, 2 Jan 2007 12:11:56 -0800
Message-ID: <20070102201156.GA9733@atomide.com>
References: <459AB907.1030102@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459AB907.1030102@balister.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Philip Balister <philip@balister.org>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Philip Balister <philip@balister.org> [070102 12:03]:
> I just built a 2.6.19 + omap patch kernel for my OSK. When I tried 
> booting it, the kernel oopsed when it started ALSA. Has anyone booted an 
> OSK using this kernel version?

This is probably because of the zero byte scan missing from linux-omap
tree as we're trying to sync things with mainline.

Please try this patch:

http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html

I'll apply it back to linux-omap tree as now there is a longer term
solution with David Brownell's I2C patches that should eventually
solve this problem for mainline kernel also.

Regards,

Tony
