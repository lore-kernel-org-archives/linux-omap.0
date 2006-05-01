From: Kevin Hilman <khilman@mvista.com>
Subject: 1710 and USB host
Date: Mon, 01 May 2006 10:54:00 -0700
Message-ID: <44564B38.9020802@mvista.com>
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

Anyone else having success using the 1710 in USB host mode?  Using the latest 
git kernel, I'm getting the boot messages below.  I have a USB key plugged in 
and it's lighting up, so presumably it's getting powered properly.

Maybe the jumpers aren't set quite right, I don't quite grok the comments 
around the 'hmc_mode' value in. board-h3.c.  In any case, my SW1501 settings 
are 1=on, and the rest are off.

Thanks for any pointers,

Kevin

isp1301_omap 0-002d: chiprev 2.00, driver 24 August 2004
MUX: initialized N21_1710_GPIO14
usbmon: debugfs is not available
isp1301_omap 0-002d: A-Host sessions ok
ohci ohci: OMAP OHCI
ohci ohci: new USB bus registered, assigned bus number 1
ohci ohci: irq 38, io mem 0xfffba000
ohci ohci: init err (00000000 0000)
ohci ohci: can't start
ohci ohci: startup error -75
ohci ohci: USB bus 1 deregistered
ohci: probe of ohci failed with error -75
