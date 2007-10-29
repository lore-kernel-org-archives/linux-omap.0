From: Dirk Behme <dirk.behme@googlemail.com>
Subject: OMAP tsc210x touchscreens?
Date: Mon, 29 Oct 2007 16:30:28 +0100
Message-ID: <4725FC94.6080808@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Because of [1] I looked into drivers/input/touchscreen/omap/ts_hx.c 
what need to be done there. And, mmh, looks like

drivers/input/touchscreen/omap

can/should be completely removed? I couldn't find any Kconfig using 
TOUCHSCREEN_OMAP, so touchscreen/omap will never compile?

Instead, touchscreen/tsc210x_ts.c should be used? tsc2102_ts.c is 
outdated and replaced by tsc210x_ts.c now as well?

Regards

Dirk


[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2007-October/011767.html
