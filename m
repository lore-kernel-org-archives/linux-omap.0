From: "JD (Jiandong) Zheng" <jdzheng@broadcom.com>
Subject: RE: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
Date: Thu, 17 Feb 2011 10:07:45 -0800
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AADDDF03CE1D9@SJEXCHCCR02.corp.ad.broadcom.com>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
	<AANLkTinwQwPK7Lg4dxkLGBxvp1hz489iAB6YrSG45e75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTinwQwPK7Lg4dxkLGBxvp1hz489iAB6YrSG45e75@mail.gmail.com>
Content-Language: en-US
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
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Kevin Hilman <khilman@deeprootsystems.com>, Anton Vorontsov <avorontsov@mvista.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Erik Gilling <konkers@android.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Vincent Sanders <support@simtec.co.uk>, "Hans J. Koch" <hjk@linutronix.de>, Magnus Damm <magnus.damm@gmail.com>, Marc Singer <elf@buici.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Wan ZongShun <mcuos.com@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ryan Mallon <ryan@bluewatersys.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 5, 2011 at 4:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> arch/arm/include/asm/memory.h                  |    2 ++
> arch/arm/kernel/tcm.c                          |    2 +-

> arch/arm/mach-bcmring/include/mach/hardware.h  |    2 +-
> arch/arm/mach-bcmring/include/mach/memory.h    |    2 +-

Acked-by: Jiandong Zheng <jdzheng@broadcom.com>
