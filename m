From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
Date: Mon, 7 Feb 2011 17:36:04 +0100
Message-ID: <20110207163604.GJ26656@game.jcrosoft.org>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Kevin Hilman <khilman@deeprootsystems.com>, Anton Vorontsov <avorontsov@mvista.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-sh@vger.kernel.org, Vincent Sanders <support@simtec.co.uk>, "Hans J. Koch" <hjk@linutronix.de>, Magnus Damm <magnus.damm@gmail.com>, Scott Branden <sbranden@broadcom.com>, Marc Singer <elf@buici.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Sascha Hauer <kernel@pengutronix.de>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.o
List-Id: linux-omap@vger.kernel.org

On 20:22 Tue 04 Jan     , Russell King - ARM Linux wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/memory.h                  |    2 ++
>  arch/arm/kernel/tcm.c                          |    2 +-
>  arch/arm/mach-aaec2000/include/mach/memory.h   |    2 +-
>  arch/arm/mach-at91/include/mach/memory.h       |    2 +-
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
