From: David Brownell <david-b@pacbell.net>
Subject: is dynamic tick working?
Date: Fri, 12 May 2006 19:05:12 -0700
Message-ID: <200605121905.13405.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

On an OSK, using today's GIT tree, I turned on dynamic tick using
sysfs and thought the IRQ rate (32 KHz timer) was odd.  So I did

  grep tim /proc/int*; sleep 60; grep tim /proc/int*

and saw 104551 IRQs, which is 1742 per second.  Too many!!  When
I turned dyntick off (on/off via sysfs) the same measurement
gave a more reasonable 7701 IRQs, making 128 per second.

In short, enabling dyntick got me 14x as many IRQs, instead of
shrinking the number of IRQs.  Known bug?

- Dave
