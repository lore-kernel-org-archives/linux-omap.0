From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: Problem in omap_pm_idle()
Date: Tue, 18 Sep 2007 19:52:05 +0530
Message-ID: <46EFDF0D.8000808@celunite.com>
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

Hi ,
       I was looking at omap_pm_idle() in omap1/pm.c , at the end there 
is a call to omap_sram_suspend , shouldn't it be omap_sram_idle() ?
       and if CONFIG_OMAP_MPU_TIMER is set it sets  use_idlect1 = 
use_idlect1 & ~(1 << 9) ,  but it does not go into wait for interrupt.
       Can anyone please explain this ?

--
Thanks
Vivek
      
