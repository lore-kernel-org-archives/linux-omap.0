From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.19 + omap patch on the OSK
Date: Wed, 3 Jan 2007 09:26:19 -0800
Message-ID: <20070103172618.GB6634@atomide.com>
References: <459AB907.1030102@balister.org> <20070102201156.GA9733@atomide.com>
	<459BE326.7030903@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459BE326.7030903@googlemail.com>
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
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070103 09:09]:
> tony@atomide.com wrote:
> >Please try this patch:
> >
> >http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html
> >
> >I'll apply it back to linux-omap tree as now there is a longer term
> >solution with David Brownell's I2C patches that should eventually
> >solve this problem for mainline kernel also.
> 
> Looks like the removal of  ~I2C_FUNC_SMBUS_QUICK was missed
> while applying it. Update of this in attachment.

Thanks. I reverted my hack, and reapplied my patch merged to yours yours
so we have a single hack patch to make merging easier.

Tony
