From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v2 03/11] mfd: omap: control: core system
 control driver
Date: Tue, 26 Jun 2012 04:17:46 -0700
Message-ID: <20120626111746.GE31393@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<4FDF11C3.4010701@dev.rtsoft.ru>
	<20120620102224.GZ12766@atomide.com>
	<4FE1DAA2.1000502@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FE1DAA2.1000502@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: J Keerthy <j-keerthy@ti.com>, amit.kucheria@linaro.org, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120620 07:18]:
> 
> So,the same API set (omap_control_readl/omap_control_writel) was added to omap-control-core.c.
> 
> If omap-control-core.c should only service users from driver/ directory, than I agree - we can remove
> omap_control_readl/omap_control_writel from omap-control-core.c.
>   But IIUC you are agree to "switch" arch/arm/mach-omap2/id.c from control.c to omap-control-core.c. If arch/arm/mach-omap2/id.c is switched to control.c, then I guess all arch/arm/mach-omap2/*.c should be "switched" to omap-control-core.c as well. But this means that omap-control-core.c should provide omap_control_readl/omap_control_writel API.

Can't you just add something like int omap_ctrl_read_status(void)
that id.c can use?

Tony
