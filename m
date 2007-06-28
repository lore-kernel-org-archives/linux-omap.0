From: "arun c" <arun.edarath@gmail.com>
Subject: what is CFG_HZ
Date: Thu, 28 Jun 2007 19:36:44 +0530
Message-ID: <c656a4d20706280706n7ae0fa4fxffb79f4acc67a0a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi all,

While going through the u-boot configurations for omap2430SDP i found
something like CFG_HZ.i am unable to find the purpose of this setting.

I guess its the same as the HZ in kernel(No of timer interrupts in a
second. Am i correct?

I am also confused with the following definitions also

#define V_PVT                                       7
#define CFG_TIMERBASE            OMAP24XX_GPT2
#define CFG_PVT                  V_PVT  /* 2^(pvt+1) */
#define CFG_HZ                   ((CONFIG_SYS_CLK_FREQ)/(2 << CFG_PVT))

Please anybody help me

Arun
