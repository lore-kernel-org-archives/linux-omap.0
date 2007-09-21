From: "arun c" <arun.edarath@gmail.com>
Subject: GP-timers for 2430
Date: Fri, 21 Sep 2007 12:55:10 +0530
Message-ID: <c656a4d20709210025r7b6e418ejadc4ae3876cf3fe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

I am working on 2430 sdp (linux 2.6.19 custom kernel).

I want to use gptimer 5 and 6 for my application.

Whether i have to enable GPtimer 5&6 in xloader or  I have to do it in
kernel?

I tried enabling them in /arch/arm/mach-omap2/timer-gp.c like this

 setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
        temp_var=omap_readl(0x49006200); //CM_FCLKEN1_CORE
        temp_var &= ~(0x00000180);
        temp_var |= (0x00000180);
        omap_writel(temp_var,0x49006200);//CM_FCLKEN1_CORE


        temp_var=omap_readl(0x49006210);//CM_ICLKEN1_CORE
        temp_var &= ~(0x00000180);
        temp_var |= (0x00000180);
        omap_writel(temp_var,0x49006210);//CM_ICLKEN1_CORE

        temp_var=omap_readl(0x49006244);//CM_CLKSEL2_CORE
        temp_var &= ~(3<<10);
        temp_var |=  (1<<10);
        omap_writel(temp_var,0x49006244);//CM_CLKSEL2_CORE

        omap2_gp_timer_start(tick_period);

But it not seemed to be working.

Some other things also i have to take care??
Please help me

Regards,

Arun
