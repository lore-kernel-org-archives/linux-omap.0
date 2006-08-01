From: tony@atomide.com
Subject: Re: osk
Date: Tue, 1 Aug 2006 03:46:22 -0700
Message-ID: <20060801104621.GC7572@atomide.com>
References: <1261849398.467961152107847327.JavaMail.nobody@mail06.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1261849398.467961152107847327.JavaMail.nobody@mail06.abv.bg>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ii kk <the_heretic@abv.bg>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* ii kk <the_heretic@abv.bg> [060705 06:58]:
> Hi,
> I bump up against very strange problem. Writing on camera interface registers ( 0xFFFB6800/0xFFFB6818 ) is unsuccessful. After writing I read 0x00000000. The platform that I use is OSK 5912, Linux Kernel is 2.6.16.

Maybe you don't have clock enabled for the camera?

Regards,

Tony
