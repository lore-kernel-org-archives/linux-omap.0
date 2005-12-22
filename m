From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: power led flashing on omap5912
Date: Thu, 22 Dec 2005 18:34:52 +0100
Message-ID: <43AAE3BC.1060707@de.bosch.com>
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
To: tushar.mathur@purplevisiontech.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tushar wrote:

> i am using a omap5912 board. when i boot the kernel image, the power
> led starts flashing. can anyone tell if this behavior ok.

Yes, it is ok.

It shows you that kernel is basically alive and reached a dedicated boot
stage. E.g. I2C works and TPS power chip is initialized correctly. This
is controlled by drivers/i2c/chips/tps65010.c in tps_init()

/* Let LED1 (D9) blink */
tps65010_set_led(LED1, BLINK);

Dirk
