From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fixup omap-rtc (was: Git tree updated to
	2.6.19-rc2)
Date: Tue, 24 Oct 2006 10:57:09 -0700
Message-ID: <200610241057.09630.david-b@pacbell.net>
References: <20061023203925.GC11967@atomide.com>
	<20061024110502.GQ1123@earth.li>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061024110502.GQ1123@earth.li>
Content-Disposition: inline
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

On Tuesday 24 October 2006 4:05 am, Jonathan McDowell wrote:

> Haven't hit any of these with the Amstrad Delta defconfig so far (just
> done a compile and boot so far), but did need the patch below to get
> omap-rtc to compile.
> 
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>

Looks right.  In fact, that RTC should IMO be added to defconfig
for all the OMAP platforms ...
