From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] plat-omap changes for 2430 SDP
Date: Tue, 14 Nov 2006 11:20:49 +0200
Message-ID: <5d5443650611140120x3c97b2bdwe444abb954a8ff9c@mail.gmail.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA524@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA524@DLEE09.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 11/14/06, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Hi,
>
> The attached patch adds 2430 support to arch/arm/plat-omap folder.
>
> The following files are modified devices.c, dmtimer.c, gpio.c, mcbsp.c
>
> Since the changes were very minimal I thought of sending them as a
> single patch.
>
> Changes:
> --------
> devices.c : Initialization of devices are commented for 2430, will
> enable the relevant once as and when required.
> dmtimer.c : Base address for Timer 1 is different from 2420.
> gpio.c    : The code is modified in few places to support GPIO 5th

+#ifdef CONFIG_ARCH_OMAP2430
+		if (cpu_is_omap2430()) {
+			gpio5_ick = clk_get(NULL, "gpio5_ick");
+			if (IS_ERR(gpio5_ick))
+				printk("Could not get gpio5_ick\n");
+			else
+				clk_enable(gpio5_ick);			
+			gpio5_fck = clk_get(NULL, "gpio5_fck");
+			if (IS_ERR(gpio5_fck))
+				printk("Could not get gpio5_fck\n");
+			else
+				clk_enable(gpio5_fck);
+		}
+#endif
+}

As clk_get gpio5_ick can really fail, we should also put proper error
return path if there is an error in getting gpio5_fck. Actually this
is required in general for other OMAP1/2 clocks in gpio.c, also printk
with KERN_INFO will be good :)

--Trilok Soni
