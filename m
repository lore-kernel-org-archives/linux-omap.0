From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Wed, 7 Aug 2013 17:52:48 -0700
Message-ID: <CA+Bv8XZFGr=PrQjw_Ed7Ny8Okki85zrtNocYKW7K0_U6nTUvQw@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-3-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:59847 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933628Ab3HHAwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 20:52:49 -0400
Received: by mail-qc0-f180.google.com with SMTP id j10so1263514qcx.25
        for <linux-omap@vger.kernel.org>; Wed, 07 Aug 2013 17:52:48 -0700 (PDT)
In-Reply-To: <1375811376-49985-3-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> Interacting with WKUP-M3 requires some more control
> module register writes. Add the register offsets and
> APIs to write to these.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/mach-omap2/control.c |   57 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/control.h |   54 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 31e0dfe..934041a 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -605,3 +605,60 @@ int omap3_ctrl_save_padconf(void)
>  }
>
>  #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
> +
> +#if defined(CONFIG_SOC_AM33XX) && defined(CONFIG_PM)
> +void am33xx_txev_eoi(void)
> +{
> +       omap_ctrl_writel(AM33XX_M3_TXEV_ACK, AM33XX_CONTROL_M3_TXEV_EOI);
> +}
> +
> +void am33xx_txev_enable(void)
> +{
> +       omap_ctrl_writel(AM33XX_M3_TXEV_ENABLE, AM33XX_CONTROL_M3_TXEV_EOI);
> +}
> +
> +/*
> + * Invalidate M3 firmware version before hardreset.
> + * Write invalid version in lower 4 nibbles of parameter
> + * register (ipc_regs + 0x8).
> + */
> +void am33xx_pm_version_clear(void)
> +{
> +       omap_ctrl_writel(0xffff0000, AM33XX_CONTROL_IPC_MSG_REG2);
> +}
> +
> +int am33xx_pm_version_get(void)
> +{
> +       return omap_ctrl_readl(AM33XX_CONTROL_IPC_MSG_REG2) & M3_VERSION_MASK;
> +}
> +
> +void am33xx_pm_ipc_cmd(struct am33xx_ipc_data *data)
> +{
> +       omap_ctrl_writel(data->resume_addr, AM33XX_CONTROL_IPC_MSG_REG0);
> +       omap_ctrl_writel(data->sleep_mode, AM33XX_CONTROL_IPC_MSG_REG1);
> +       omap_ctrl_writel(data->param1, AM33XX_CONTROL_IPC_MSG_REG2);
> +       omap_ctrl_writel(data->param2, AM33XX_CONTROL_IPC_MSG_REG3);
> +       omap_ctrl_writel(data->param3, AM33XX_CONTROL_IPC_MSG_REG4);
> +}
> +
> +int am33xx_pm_status(void)
> +{
> +       int i;
> +
> +       i = omap_ctrl_readl(AM33XX_CONTROL_IPC_MSG_REG1);
> +       i &= IPC_RESP_MASK;
> +       i >>= __ffs(IPC_RESP_MASK);
> +
> +       return i;
> +}
> +
> +int am33xx_pm_wake_src(void)
> +{
> +       int i;
> +
> +       i = omap_ctrl_readl(AM33XX_CONTROL_IPC_MSG_REG6);
> +       i &= 0xff;
> +
> +       return i;
> +}
> +#endif /* CONFIG_SOC_AM33XX && CONFIG_PM */
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index f7d7c2e..9be587c 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -370,6 +370,22 @@
>  #define AM33XX_DEV_FEATURE             0x604
>  #define AM33XX_SGX_MASK                        BIT(29)
>
> +/* AM33XX M3_TXEV_EOI register */
> +#define AM33XX_CONTROL_M3_TXEV_EOI     0x1324
> +
> +#define AM33XX_M3_TXEV_ACK             (0x1 << 0)
> +#define AM33XX_M3_TXEV_ENABLE          (0x0 << 0)
> +
> +/* AM33XX IPC message registers */
> +#define AM33XX_CONTROL_IPC_MSG_REG0    0x1328
> +#define AM33XX_CONTROL_IPC_MSG_REG1    0x132C
> +#define AM33XX_CONTROL_IPC_MSG_REG2    0x1330
> +#define AM33XX_CONTROL_IPC_MSG_REG3    0x1334
> +#define AM33XX_CONTROL_IPC_MSG_REG4    0x1338
> +#define AM33XX_CONTROL_IPC_MSG_REG5    0x133C
> +#define AM33XX_CONTROL_IPC_MSG_REG6    0x1340
> +#define AM33XX_CONTROL_IPC_MSG_REG7    0x1344
> +
>  /* CONTROL OMAP STATUS register to identify OMAP3 features */
>  #define OMAP3_CONTROL_OMAP_STATUS      0x044c
>
> @@ -429,6 +445,44 @@ extern void omap3630_ctrl_disable_rta(void);
>  extern int omap3_ctrl_save_padconf(void);
>  extern void omap2_set_globals_control(void __iomem *ctrl,
>                                       void __iomem *ctrl_pad);
> +struct am33xx_ipc_data {
> +       u32 resume_addr;
> +       u32 sleep_mode;
> +       u32 param1;
> +       u32 param2;
> +       u32 param3;
> +       u32 param4;
> +       u32 param5;
> +       u32 param6;
> +};
> +
> +#define IPC_RESP_SHIFT                 16
> +#define IPC_RESP_MASK                  (0xffff << 16)
> +
> +#define M3_VERSION_SHIFT               0
> +#define M3_VERSION_MASK                        (0xffff << 0)
> +
> +/*
> + * 9-4 = VTT GPIO PIN (6 Bits)
> + *   3 = VTT Status (1 Bit)
> + * 2-0 = Memory Type (2 Bits)
> +*/
> +#define MEM_TYPE_SHIFT         (0x0)
> +#define MEM_TYPE_MASK          (0x7 << 0)
> +#define VTT_STAT_SHIFT         (0x3)
> +#define VTT_STAT_MASK          (0x1 << 3)
> +#define VTT_GPIO_PIN_SHIFT     (0x4)
> +#define VTT_GPIO_PIN_MASK      (0x2f << 4)
> +
> +extern void am33xx_wkup_m3_ipc_cmd(struct am33xx_ipc_data *data);
> +extern void am33xx_txev_eoi(void);
> +extern void am33xx_txev_enable(void);
> +extern void am33xx_pm_version_clear(void);
> +extern int am33xx_pm_version_get(void);
> +extern void am33xx_pm_ipc_cmd(struct am33xx_ipc_data *data);
> +extern int am33xx_pm_status(void);
> +extern int am33xx_pm_wake_src(void);
> +
>  #else
>  #define omap_ctrl_base_get()           0
>  #define omap_ctrl_readb(x)             0
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
