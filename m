From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/5] soc: ti: pm33xx: Push the am33xx_push_sram_idle
 to the top
Date: Tue, 2 Apr 2019 10:34:03 -0700
Message-ID: <20190402173403.GQ49658@atomide.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
 <20190402034253.4928-5-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190402034253.4928-5-j-keerthy@ti.com>
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

* Keerthy <j-keerthy@ti.com> [190402 03:43]:
> Push the am33xx_push_sram_idle function to the top as a preparation
> for rtc+ddr mode as the function will be called by multiple functions
> currently present before it.

How about say "Move the am33xx_push_sram_idle function to the top..."
instead? And mention no functional changes assuming there aren't
any.

Regards,

Tony
