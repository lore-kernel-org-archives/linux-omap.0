From: Kevin Hilman <khilman@mvista.com>
Subject: RE: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Wed, 21 Mar 2007 12:50:10 -0700
Message-ID: <1174506610.15255.101.camel@vence.hilman.org>
References: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Jalori, Mohit" <mjalori@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, 2007-03-21 at 14:15 -0500, Jalori, Mohit wrote:

> > RFC: Notice the change to onenand_base.c which comments out the last
> >      OOB chunk.  Without this, it would not work.  Previous drivers
> >      for this board such as the 2.6.10-based MV kernel have this
> >      same change.  Anyone know what is going on here?
> > 
> 
> We got this change from MV in the patch he sent to fix an issue we were
> seeing with mounting an empty jffs2 partition. Here are the comments
> that came in with it
> 
> " The oobfree list in the MTD OneNAND driver is of length 8.  This
> exceeds the maximum length of 7, because the eighth entry must be used
> as a null terminator.  The absence of a terminator causes a variety of
> problems in various places (especially JFFS2 and YAFFS2) where the
> oobfree list is scanned.  The fix is to do without the eighth entry. 
> 
> This fix is only of local interest because the handling of oobinfo has
> been completely redesigned as of 2.6.17-rc6. "

This problem still exists in the current OMAP tree (2.6.21-rc4), so the
MTD driver still needs some work.

I will work to get a fix for this submitted upstream.  In the mean-time,
my patch is required for OneNAND to work in the current git tree.

Kevin
