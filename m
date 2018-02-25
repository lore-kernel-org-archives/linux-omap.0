From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v5 0/4] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume
 support
Date: Sun, 25 Feb 2018 15:35:21 -0800
Message-ID: <a56830af-cf81-3603-ba58-2a2c65c49f34@oracle.com>
References: <20180223154357.23504-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223154357.23504-1-d-gerlach@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 2/23/2018 7:43 AM, Dave Gerlach wrote:
> Hi,
> 
> This is a minor update to previous series sent here [1] to switch to
> SPDX license headers. Because update is so minor I have included original
> cover letter below unmodified with the exception of updated links.
> 
> This series contains the remaining code to enable suspend to mem and standby
> on am335x and am437x platforms. All dependencies have been merged and this
> is just a rebase on v4.16-rc1. For this to work on am437x-gp-evm this
> bug fix patch [2] is required but suspend works fine on am335x platforms
> without it. V3 of this series can be found here [3].
> 
> This code also depends on firmware for the wkup_m3 that is available here [4]
> that can either be placed in /lib/firmware or built in to the kernel.
> 
> For testing the drivers required are:
> 
> CONFIG_MAILBOX
> CONFIG_OMAP2PLUS_MBOX
> CONFIG_WKUP_M3_RPROC
> CONFIG_SOC_TI
> CONFIG_WKUP_M3_IPC
> CONFIG_TI_EMIF_SRAM
> CONFIG_AMX3_PM
> 
> There is a device tree patch series to follow immediately after this that will
> completely enable suspend, all patches pushed here [5] for convenience
> including the aforementioned [2] regulator bug fix if anyone is testing.
> 
> Regards,
> Dave
> 
> [1] https://www.spinics.net/lists/linux-omap/msg141652.html
> [2] https://www.spinics.net/lists/linux-omap/msg141626.html
> [3] https://www.spinics.net/lists/arm-kernel/msg595931.html
> [4] https://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware/blobs/7eb9c0856a9e8b3b42bf64f761da135852b8eea7/bin/am335x-pm-firmware.elf
> [5] https://github.com/dgerlach/linux-pm/tree/upstream/v4.16/amx3-suspend-v5
> 
> Dave Gerlach (4):
>    ARM: OMAP2+: Introduce low-level suspend code for AM33XX
>    ARM: OMAP2+: Introduce low-level suspend code for AM43XX
>    ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
>    soc: ti: Add pm33xx driver for basic suspend support
> 
Are you going to pickup this series ?

Regards,
Santosh
