From: jeffrey_chuang@accton.com.tw
Subject: how to write/read HDQ bus device
Date: Fri, 29 Jun 2007 10:34:14 +0800
Message-ID: <OFE76AA642.970231BB-ON48257309.000C9B24-48257309.000E0BEF@accton.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hello All

I am using 2.6.14 kernel , I found HDQ interface @ following path

=================================================================
# cd /sys/devices/platform/omap_hdq.0/bus/devices/omap_hdq.0
# ls
bus     cmd     power   result
=================================================================

i can open it as below message ,

=================================================================
# echo open > cmd
OMAP_HDQ:sysfs cmd: *open*, len=4, count=5
OMAP_HDQ:process open cmd ...
OMAP_HDQ:exiting cmd_set, 0
#
=================================================================

but I do not how to write 0x55 to DHQ device(bq27000) register address
0x00~0x7F
or read data from it.

any body can help me ? thank you

Jeffrey
