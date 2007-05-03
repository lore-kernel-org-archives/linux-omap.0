From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] musb/tusb6010 fixes for host mode
Date: Thu,  3 May 2007 16:41:51 +0000
Message-ID: <11782105181141-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: musb-2007-05-03-164131
References: musb-2007-05-03-164131
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

Hi all,

Here are some USB patches that make tusb6010 host mode work
finally reliably on at least N800. Now all testusb cases pass
with N800 running as a host.

Some of the patches should also help other musb devices.

I'd like to push them to linux-omap tree, so please test
and comment.

Regards,

Tony
