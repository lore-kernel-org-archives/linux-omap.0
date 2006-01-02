From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problem on mounting a jffs2 rootfs image
Date: Mon, 2 Jan 2006 14:10:28 -0800
Message-ID: <20060102221028.GJ6034@atomide.com>
References: <43741c56.6400405c.6f4c.ffff87c0@mx.gmail.com>
	<43743DC9.1090702@de.bosch.com>
	<20051111173755.GC10822@atomide.com>
	<4374F44A.7080807@de.bosch.com> <20060102183107.GH6034@atomide.com>
	<43B98EA2.9040509@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43B98EA2.9040509@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [060102 12:36]:
> Tony Lindgren wrote:
> >>0x30003361 is the value used by spectrum digital. Seems to work. But I 
> >>don't think it's the fastest possible timing. Anybody with a better CS3 
> >>timing?
> >
> >
> >I think we should push this to avoid postings on JFFS2 problems. How
> >about changing the patch to use the EMIFS_CCS macro instead?
> 
> Something like this?

This should do it:

if (EMIFS_CCS(3) != EMIFS_CS3_VAL)
	EMIFS_CCS(3) = EMIFS_CS3_VAL;

It's a REG32 define.
 
> Nobody with a better timing?

I guess not.

Tony
