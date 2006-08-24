From: "Anand SVR" <anand.svr@gmail.com>
Subject: omap850 : MMC connected to GPIO ?
Date: Thu, 24 Aug 2006 21:11:53 +0530
Message-ID: <48a4d13c0608240841x32106f3eo92aeeaa448a4de7e@mail.gmail.com>
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
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I am trying to bring up the sd card on my omap850 based pda. The
omap.c code snippet as given below within mmc_omap_power () doesn't
have a check either for omap850 or omap730.  So, the code is falling
off to  omap_set_gpio_dataout() and subsequently the pda is getting
frozen. In the same code, what cpu does omap850 come under ?

I would like to know if the mmc/sd on omap850 connected to GPIO. I am
not finding the relevant datasheet that could answer my doubt. I would
really appreciate if someone could clarify.

Regards
Anand

The code snippet ....


...
  if (machine_is_omap_innovator())
               mmc_omap_power         innovator_fpga_socket_power(0);
                else if (machine_is_omap_h2())
                        tps65010_set_gpio_out_value(GPIO3, LOW);
                else if (machine_is_omap_h3())
                        tps65010_set_gpio_out_value(GPIO4, LOW);
                else if (cpu_is_omap24xx()) {
                        u16 reg = OMAP_MMC_READ(host->base, CON);
                        OMAP_MMC_WRITE(host->base, CON, reg & ~(1 << 11));
                } else if (host->power_pin >= 0)
                                omap_set_gpio_dataout(host->power_pin, 0);
...
