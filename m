From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3 1/4] arm:omap:am33xx: Update common omap platform files
Date: Thu, 6 Oct 2011 16:03:34 -0700
Message-ID: <20111006230334.GY6324@atomide.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1316529142-27564-2-git-send-email-hvaibhav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hvaibhav@ti.com
Cc: khilman@ti.com, paul@pwsan.com, Hemant Pedanekar <hemantp@ti.com>, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* hvaibhav@ti.com <hvaibhav@ti.com> [110920 06:59]:
> From: Afzal Mohammed <afzal@ti.com>
> 
> This patch updates the common platform files with AM335X device
> support (AM33XX family).
> 
> The approach taken in this patch is,
> AM33XX device will be considered as OMAP3 variant, and a separate
> SoC class created for AM33XX family of devices with a subclass type
> for AM335X device, which is newly added device in the family.
> 
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and cpu_is_am335x()
> checks will return success on AM335X device.
> A kernel config option CONFIG_SOC_OMAPAM33XX is added under OMAP3
> to include support for AM33XX build.
> 
> Also, cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence
> struct clksel_rate.flags, struct prcm_config.flags and cpu_mask
> are changed to u16 from u8.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Hemant Pedanekar <hemantp@ti.com>

I'll add this one into soc branch.

Regards,

Tony
