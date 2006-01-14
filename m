From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Convert touchscreen to input_allocate_device
Date: Fri, 13 Jan 2006 16:18:12 -0800
Message-ID: <20060114001811.GH5499@atomide.com>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
	<20060103191356.GR6034@atomide.com> <43BEC6EC.6060204@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43BEC6EC.6060204@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [060106 11:36]:
> Tony Lindgren wrote:
> >Dirk, I've only pushed Todd's timer fix below like you suggested. Can you 
> >please
> >update your patch?
> 
> ARM: OMAP: Convert touchscreen to input_allocate_device() to remove:
> 
> input: device omap_ts is statically allocated, will not register
> Please convert to input_allocate_device() or contact dtor_core@ameritech.net

Pushing this one today, thanks.

Tony
