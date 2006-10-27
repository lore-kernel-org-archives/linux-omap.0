From: Jonathan McDowell <noodles@earth.li>
Subject: Re: omap-keypad issues with 2.6.19-rc?
Date: Fri, 27 Oct 2006 17:16:59 +0100
Message-ID: <20061027161659.GP13361@earth.li>
References: <20061023203925.GC11967@atomide.com>
	<20061024110502.GQ1123@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061024110502.GQ1123@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 24, 2006 at 12:05:02PM +0100, Jonathan McDowell wrote:
> On Mon, Oct 23, 2006 at 11:39:26PM +0300, Tony Lindgren wrote:
> > I've updated our git tree to 2.6.19-rc2. At least following have
> > problems on omap1 (OSK):
> > 
> > - CONFIG_DEBUG_LL hangs system
> > - BUG in omap1_mbox_enable_irq
> > - Aic23 NULL pointer exception
> > 
> > So YMMV :) Anybody got patches for these issues already?
> 
> Haven't hit any of these with the Amstrad Delta defconfig so far (just
> done a compile and boot so far), 

However having prodded further I'm seeing incorrect key parsing with
the omap-keypad driver under both -rc2 and -rc3 (works fine in
2.6.18-omap1). Numerous keys now returns strings of characters rather
than the single expected character. A few keys still work as expected
however. Before I dig in further is anyone else seeing anything similar?

J.

-- 
 After a number of decimal places,  |       Black Cat Networks Ltd
       nobody gives a damn.         | http://www.blackcatnetworks.co.uk/
                                    |  UK Web, domain and email hosting
