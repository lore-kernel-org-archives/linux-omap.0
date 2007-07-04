From: "arun c" <arun.edarath@gmail.com>
Subject: What must be the value of CFG_HZ in uboot
Date: Wed, 4 Jul 2007 18:30:57 +0530
Message-ID: <c656a4d20707040600h741d2ea1k8d5840354963d904@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I am working on omap2430sdp uboot(1.1.4)
In the uboot CHANGELOG  i saw that the CFG_HZ value must be
1000 for all the systems.

But in my config file its like this

#define V_SCLK                   13000000
#define CONFIG_SYS_CLK_FREQ      V_SCLK
#define V_PVT                    7
#define CFG_TIMERBASE            OMAP24XX_GPT2
#define CFG_PVT                  V_PVT
#define CFG_HZ                   ((CONFIG_SYS_CLK_FREQ)/(2 << CFG_PVT))

1) I never see any use of CONFIG_SYS_CLK_FREQ in uboot
           do i need to define this??
2) Can i change the CFG_HZ value to 1000 without breaking uboot??

3)Whats exactly the use of CFG_HZ?? From reading the sources i
 understood that its system independent, is it correct?

Best regards
Arun
