From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: OSK touchscreen broken
Date: Sun, 22 Jan 2006 17:26:23 +0100
Message-ID: <43D3B22F.5050003@de.bosch.com>
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

Hi,

in recent git the OSK touchscreen is broken. Seems that we didn't get 
any interrupts. Does touchscreen work on other boards?

# ts_calibrate
xres = 240, yres = 320

-> nothing happens if touching the screen, CTRL-C stops this
# cat /proc/interrupts
            CPU0
...
164:          0   omap_ts
...

GPIO IRQT patch is applied. Any other ideas?

Thanks

Dirk
