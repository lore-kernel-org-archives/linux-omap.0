From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 0/2] HS-USB support for 2430SDP
Date: Thu, 10 May 2007 11:34:05 -0700
Message-ID: <20070510183405.565400315@mvista.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Here is base support for MUSB on the 2430SDP.  It adds mux fixup and
mux regs for HS-USB and the MUSB platform setup code.  Currently works
for gadget only.

Tested on OMAP2430SDP-v2.2 and v5.0.

Kevin

--
