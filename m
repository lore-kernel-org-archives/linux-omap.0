From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: [PATCH 0/1] TWL4030 Real-Time Clock (v2)
Date: Fri, 01 Jun 2007 11:08:48 +0400
Message-ID: <20070601070835.5266.13212.stgit@T60>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

the following patch adds support for Real-Time Clock device which is 
an internal subdevice of TWL4030 chip. Issues found by Trilok in previous
patch are fixed. 

The driver is based on TI's one from 2.6.14 tree. Comparing with TI's driver, 
this driver misses periodic IRQ functionality (RTC_IRQP_..., RTC_PIE_... ),
since TWL4030 RTC hardware supports too large periods (1s/1m/1h/1d) to be set 
via frequiencies (Hz) except 1s period which is 1Hz and is already supported 
as update IRQs. To support 1m/1h/1d interrups, probably new ioctls should be
added.

Known issue:

    The alarm IRQ doesn't work after power reset until RTC time (RTC_SET_TIME) 
    is not set, the issue is also observed with original TI's driver.
    
    
Regards,
Dmitry
