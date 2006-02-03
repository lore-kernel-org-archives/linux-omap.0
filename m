From: Brian Swetland <swetland@google.com>
Subject: OMAPFB_FILLRECT and friends
Date: Fri, 3 Feb 2006 11:11:57 -0800
Message-ID: <20060203191157.GA23171@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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


It appears that an older version of the omapfb driver had support for
ioctls to FILLRECT, COPYAREA, TRANSPARENT_BLIT, etc.  A bit of searching
found this version at:
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=aeb66c8fbb09bb675a4662a5c055d0162f5e109f

Being unwise in the way of git or gitweb, I have no idea how to go 
from this page to "where in space or time does this stuff live".
Any pointers?  Was this stuff once there and later removed (it
doesn't seem to be in tip of tree) and if so, why?

Curious,

Brian
