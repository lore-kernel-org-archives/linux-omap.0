From: Tony Lindgren <tony@atomide.com>
Subject: Re: Power domain addition.
Date: Tue, 20 Jun 2006 11:09:01 -0700
Message-ID: <20060620180901.GE4257@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A506363C90@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A506363C90@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [060615 16:14]:
> 
> > Do you have a patch for your changes?
> 
> Just the hack I did for booting yesterday which is attached.  I tried
> quickly to make a MT_MEMORY_COHERENT so it could use page tables not
> just section entries but that required some changes elsewhere and I just
> made it a section entry.

OK, I've pushed that chunk along with Komal's smc91x patches so H4 boots
and works with PM and cpufreq.
 
> Also the USB msuspend signal is hooked up else you won't sleep.

I'll take a look at the PM stuff soon once I have something else out of
the way.

Regards,

Tony
