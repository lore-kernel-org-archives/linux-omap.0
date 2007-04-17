From: Tony Lindgren <tony@atomide.com>
Subject: Re: Touchscreen on H4
Date: Tue, 17 Apr 2007 20:02:53 +0000
Message-ID: <20070417200252.GF26287@atomide.com>
References: <986017390704120617j50c9bf9fida381ff8417ca59a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <986017390704120617j50c9bf9fida381ff8417ca59a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Alexandre Bouillot <alexandre@bouillot.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Alexandre Bouillot <alexandre@bouillot.org> [070412 13:18]:
> Hi,
> 
> I noticied the SPI drivers have been reworked for the TCS2101 recently. I'm
> wondering what is the plan for re-enabling the touchscreen support fot the
> 2420 H4 board which require it.

I don't know that anybody is working on it, but yes it should be done.
Also, it may be possible to combine some of the code across the TSC
chips.

Regards,

Tony
