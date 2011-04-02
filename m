From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: arm: pmu: support pmu/perf on OMAP4 - booting problem on
	pandaboard
Date: Sat, 2 Apr 2011 13:27:05 +0800
Message-ID: <BANLkTi=nOR=yX=QgbyCoYUE1U7DPxUCCzw@mail.gmail.com>
References: <4D95E244.1050400@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D95E244.1050400@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Avik Sil <aviksil@linux.vnet.ibm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Avik,

2011/4/1 Avik Sil <aviksil@linux.vnet.ibm.com>:
> Hi,
>
> I've applied the patches in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045283.html
> on top of a linaro kernel which resulted in booting problem on Pandaboard.
> It hangs inside the cti_unlock() while reading the LOCKSTATUS value, which
> happens when omap_init_pmu() is called. Please help me debug the issue.

Please check if  l3 clocks are enabled to drive CTI, such as done in below:

       omap_writel(1, CM_L3INSTR_L3_3_CLKCTRL);
       omap_writel(1, CM_L3INSTR_L3_INSTR_CLKCTRL);
       omap_writel(2, CM_EMU_CLKSTCTRL);
       while ((omap_readl(CM_EMU_CLKSTCTRL) & 0x300) != 0x300);

No such issue on mainline since this clocks are enabled automatically.

thanks,
-- 
Ming Lei
