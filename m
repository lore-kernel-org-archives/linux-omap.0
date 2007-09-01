From: Kevin Hilman <khilman@mvista.com>
Subject: MUSB: unreliable OTG detection in host mode
Date: Fri, 31 Aug 2007 17:05:37 -0700
Message-ID: <46D8ACD1.8030101@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Is anyone else using the MUSB driver in OTG mode?

On 2430, I've noticed that using the driver built in OTG mode, the
detection of devices in host-mode is unreliable.  Building the driver in
only host mode doesn't have any problems with the same devices connected.

I load the musb_hdrc module, then the g_zero module to initiate OTG
detection.

If my board is connected as a gadget, this works just fine, but if my
board is the host and I have devices connected, the detection doesn't
work reliably.  In the past it seemed it would work most of the time,
but with the latest kernel, it doesn't seem to work at all.

Any ideas?

Kevin
