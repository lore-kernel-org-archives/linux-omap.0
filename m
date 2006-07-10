From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Compile time failure with latest kernel sources
Date: Mon, 10 Jul 2006 22:31:06 +0100
Message-ID: <20060710213106.GI26313@earth.li>
References: <44B2C05D.9060005@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <44B2C05D.9060005@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 10, 2006 at 02:02:21PM -0700, Khem Raj wrote:
> I am getting this build time error. with latest sources from omap tree.
> 
>  CC      drivers/video/omap/omapfb_main.o
> drivers/video/omap/omapfb_main.c: In function 'omapfb_do_probe':
> drivers/video/omap/omapfb_main.c:1441: error: too few arguments to 
> function 'omap_set_dma_priority'

Have you read Dirk Behme's mail at:

http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007508.html

?

J.

-- 
/-\                             |  I'm from the government. I'm here
|@/  Debian GNU/Linux Developer |            to help you.
\-                              |
