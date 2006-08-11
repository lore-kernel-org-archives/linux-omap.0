From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP: Fix OMAP1 compilation after MPUIO check change.
Date: Fri, 11 Aug 2006 12:54:37 +0300
Message-ID: <20060811095436.GD6720@atomide.com>
References: <20060809092544.GK27094@earth.li> <44DA73DF.7080308@northlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <44DA73DF.7080308@northlink.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Mark Howell <mhowell@northlink.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Mark Howell <mhowell@northlink.com> [060810 02:47]:
> Jonathan McDowell wrote:
> >The recent MPUIO range change fix breaks compilation if
> >CONFIG_ARCH_OMAP24XX isn't defined; it should be OMAP_MAX_GPIO_LINES not
> >MAX_GPIO_LINES I believe. This one liner fixes it.
> >
> 
> Thanks, this works for me on my 1611 H2 with today's 2.6.18-rc4 from
> git. Mark.

Good to hear! Pushing today.

Tony
