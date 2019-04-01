From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Date: Mon, 1 Apr 2019 10:52:45 -0700
Message-ID: <20190401175245.GJ49658@atomide.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
 <20190322171619.4180-4-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190322171619.4180-4-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Keerthy <j-keerthy@ti.com> [190322 17:16]:
> +static int am43xx_check_off_mode_enable(void)
> +{
> +	/*
> +	 * Check for am437x-sk-evm which due to HW design cannot support
> +	 * this mode reliably.
> +	 */
> +	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mode) {
> +		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
> +		return 0;
> +	}
> +
> +	return enable_off_mode;
> +}

Considering off-mode suspend depends on how the board is
wired for various things such as memory, PMIC and the related
signal lines, I agree using the machine compatible is the best
check we can do here.

But since the device can hang during suspend unless things are
configured right for the board, I suggest you rather list allowed
boards here that are known to work with off-mode.

Otherwise many out-of-tree boards might hang during suspend
mysteriously.

Regards,

Tony
