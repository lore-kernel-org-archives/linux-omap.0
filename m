From: Imre Deak <imre.deak@nokia.com>
Subject: Re: OMAPFB_FILLRECT and friends
Date: Mon, 06 Feb 2006 10:26:15 +0200
Message-ID: <1139214375.29549.13.camel@mammoth.research.nokia.com>
References: <20060203191157.GA23171@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060203191157.GA23171@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, 2006-02-03 at 11:11 -0800, ext Brian Swetland wrote:
> It appears that an older version of the omapfb driver had support for
> ioctls to FILLRECT, COPYAREA, TRANSPARENT_BLIT, etc.  A bit of searching
> found this version at:
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=aeb66c8fbb09bb675a4662a5c055d0162f5e109f
> 
> Being unwise in the way of git or gitweb, I have no idea how to go 
> from this page to "where in space or time does this stuff live".
> Any pointers?  

You can check out a specific version based on the commit id with

$ git checkout -b <branch> <commit id>

> Was this stuff once there and later removed (it
> doesn't seem to be in tip of tree) and if so, why?

Yes, I removed it because later performance testing showed no
improvement whatsoever when using DMA for SDRAM - SDRAM transfers
compared to using MPU bursts.

Being a dead code I didn't see any reason leaving it in the driver.

--Imre

> 
> Curious,
> 
> Brian
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
