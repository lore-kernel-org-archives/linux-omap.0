From: Imre Deak <imre.deak@nokia.com>
Subject: Edge selecton on SPI bus
Date: Mon, 15 May 2006 14:05:15 +0300
Message-ID: <1147691115.32613.10.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: David Brownell <david-b@pacbell.net>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I think the edge selection in the omap_uwire and omap2_mcspi is borked.
I have a patch for it, but I'd like to ask first if my assumption is
right:
On the SPI / uWire bus by definition you can only configure a mode (one
of the 4 modes), in which the read / write takes place on opposite
edges. That is you can't configure for example a read rising edge /
write rising edge mode.

On OMAP2 this I even see from the fact that you can set the reading edge
and the writing edge is implied.

--Imre
