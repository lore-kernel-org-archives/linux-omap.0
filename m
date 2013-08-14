From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 1/4] ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
Date: Wed, 14 Aug 2013 15:34:55 -0700
Message-ID: <CA+Bv8XZ-QGhVV1mK=rRekOZzaTDN-Y9YkWYYoEc8EtvP0JouEA@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376432412-8509-2-git-send-email-Russ.Dill@ti.com>
	<520B595F.2040207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:43544 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149Ab3HNWe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 18:34:56 -0400
In-Reply-To: <520B595F.2040207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gururaja Hebbar <gururaja.hebbar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, devicetree@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 14, 2013 at 3:18 AM, Gururaja Hebbar <gururaja.hebbar@ti.com> wrote:
> On 8/14/2013 3:50 AM, Russ Dill wrote:
>> Changes since v1:
>> * Rebased onto new am335x PM branch
>> * Changed to use 5th param register
>>
>> Changes since v2:
>> * Passes I2C bus speed in kHz to M3 firmware
>>
>> Changes since v3:
>> * Rebased to 3.11-rc3, moves some functionality to wkup_m3.c
>> * Additional comments
>> * Added device-tree binding documentation
>
> AFAIK, Change logs should come below scissors line (---).
> However there was some discussion to keep it in the commit message.
> Don't know what happened to it finally. But till date, all revision
> patch set has the change log under the scissor line.

Will fix is v2.

>>
>> This patch adds the ability to pass an I2C sleep sequence and wake sequence
>> to the Cortex-M3. This is useful for adjusting voltages during sleep that
>> cannot be lowered while SDRAM is active. A modified M3 firmware with I2C
>> support is required.
>>
>> Each sequence is a series of I2C transfers in the form:
>>
>> u8 length | u8 chip address | u8 byte0/reg address | u8 byte 1 | u8 byte n ...
>>
>> The length indicates the number of bytes to transfer, including the register
>> address. The length of each transfer is limited by the I2C buffer size of
>> 32 bytes.
>>
>> The sequences are taken from the i2c1 node in the device tree. The property
>> name for the sleep sequence is "sleep_sequence" and the property name for
>> the wake sequence is "wake_sequence". Each property should be an array of
>> bytes.
>>
>> No actions are performed if the properties are not present in the device
>> tree.
>>
>> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
>> ---
>>  .../devicetree/bindings/i2c/i2c-suspend-resume.txt | 44 +++++++++++
>>  arch/arm/mach-omap2/control.c                      |  1 +
>>  arch/arm/mach-omap2/pm33xx.c                       | 89 ++++++++++++++++++++++
>>  arch/arm/mach-omap2/pm33xx.h                       |  2 +
>>  arch/arm/mach-omap2/wkup_m3.c                      | 57 ++++++++++++--
>>  5 files changed, 186 insertions(+), 7 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-suspend-resume.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-suspend-resume.txt b/Documentation/devicetree/bindings/i2c/i2c-suspend-resume.txt
>> new file mode 100644
>> index 0000000..af19372
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-suspend-resume.txt
>> @@ -0,0 +1,44 @@
>> +I2C suspend/resume sequences
>> +
>> +This provides the ability for a simple I2C sequence to be written at
>> +suspend time and resume time. This is for sequences that cannot be written
>> +by the I2C bus driver for reasons such as needing to be run from SRAM
>> +or needing to be written by firmware.
>> +
>> +The sequence is composed of messages. Each message contains a length byte,
>> +an address byte, and then the message.
>> +
>> +Optional properties:
>> +- sleep_sequence
>> +     I2C sequence to write during suspend
>> +
>> +- wake_sequence
>> +     I2C sequence to write during wake
>> +
>> +Examples :
>> +
>> +i2c0: i2c@0 {
>> +     /* Set OPP50 (0.95V) for VDD core */
>> +     sleep_sequence = /bits/ 8 <
>> +             0x02 0x24 0x0b 0x6d /* Password unlock 1 */
>> +             0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
>> +             0x02 0x24 0x0b 0x6d /* Password unlock 2 */
>> +             0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
>> +             0x02 0x24 0x0b 0x6c /* Password unlock 1 */
>> +             0x02 0x24 0x11 0x86 /* Apply DCDC changes */
>> +             0x02 0x24 0x0b 0x6c /* Password unlock 2 */
>> +             0x02 0x24 0x11 0x86 /* Apply DCDC changes */
>> +     >;
>
> This data is not related to i2c. Right? Then why is it under i2c dt node?
>
> There is already a wakeup node (wkup_m3) and a pmic node (pmic node for
> respective boards). Can't these details go under those nodes?

The i2c node was chosen for several reasons. First that the bus speed
is included in the message to the CM3 firmware. The bus speed and
sequence can then be read from the same device tree node. Second so
it's clear which I2C bus this is being sent out on. Including it under
the PMIC node would mean that the code would have to search each child
of the I2C bus for a sequence and if multiple children had sequences,
it would not know in which order to send those sequences out.

>> +
>> +     /* Set OPP100 (1.10V) for VDD core */
>> +     wake_sequence = /bits/ 8 <
>> +             0x02 0x24 0x0b 0x6d /* Password unlock 1 */
>> +             0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
>> +             0x02 0x24 0x0b 0x6d /* Password unlock 2 */
>> +             0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
>> +             0x02 0x24 0x0b 0x6c /* Password unlock 1 */
>> +             0x02 0x24 0x11 0x86 /* Apply DCDC changes */
>> +             0x02 0x24 0x0b 0x6c /* Password unlock 2 */
>> +             0x02 0x24 0x11 0x86 /* Apply DCDC changes */
>> +     >;
>> +}
>> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
>> index 934041a..dfbd5f0 100644
>> --- a/arch/arm/mach-omap2/control.c
>> +++ b/arch/arm/mach-omap2/control.c
>> @@ -639,6 +639,7 @@ void am33xx_pm_ipc_cmd(struct am33xx_ipc_data *data)
>>       omap_ctrl_writel(data->param1, AM33XX_CONTROL_IPC_MSG_REG2);
>>       omap_ctrl_writel(data->param2, AM33XX_CONTROL_IPC_MSG_REG3);
>>       omap_ctrl_writel(data->param3, AM33XX_CONTROL_IPC_MSG_REG4);
>> +     omap_ctrl_writel(data->param4, AM33XX_CONTROL_IPC_MSG_REG5);
>>  }
>>
>>  int am33xx_pm_status(void)
>> diff --git a/arch/arm/mach-omap2/pm33xx.c b/arch/arm/mach-omap2/pm33xx.c
>> index d291c76..8880da3 100644
>> --- a/arch/arm/mach-omap2/pm33xx.c
>> +++ b/arch/arm/mach-omap2/pm33xx.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/ti_emif.h>
>>  #include <linux/omap-mailbox.h>
>>
>> +#include <asm/unaligned.h>
>>  #include <asm/suspend.h>
>>  #include <asm/proc-fns.h>
>>  #include <asm/sizes.h>
>> @@ -50,6 +51,10 @@
>>  static void __iomem *am33xx_emif_base;
>>  static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm, *mpu_pwrdm;
>>  static struct clockdomain *gfx_l4ls_clkdm;
>> +static char *am33xx_i2c_sleep_sequence;
>> +static char *am33xx_i2c_wake_sequence;
>> +static size_t i2c_sleep_sequence_sz;
>> +static size_t i2c_wake_sequence_sz;
>>
>>  struct wakeup_src wakeups[] = {
>>       {.irq_nr = 35,  .src = "USB0_PHY"},
>> @@ -232,12 +237,34 @@ static void am33xx_m3_state_machine_reset(void)
>>  static int am33xx_pm_begin(suspend_state_t state)
>>  {
>>       int i;
>> +     unsigned long param4;
>> +     int pos;
>>
>>       cpu_idle_poll_ctrl(true);
>>
>> +     param4 = DS_IPC_DEFAULT;
>> +
>> +     wkup_m3_reset_data_pos();
>> +     if (am33xx_i2c_sleep_sequence) {
>> +             pos = wkup_m3_copy_data(am33xx_i2c_sleep_sequence,
>> +                                             i2c_sleep_sequence_sz);
>
> Why do we need to copy this data (same constant data) on every iteration?

Because the CM3 firmware is reset after each suspend/resume cycle. The
firmware reset handler reinitializes the DMEM.

>> +             /* Lower 16 bits stores offset to sleep sequence */
>> +             param4 &= ~0xffff;
>> +             param4 |= pos;
>> +     }
>> +
>> +     if (am33xx_i2c_wake_sequence) {
>> +             pos = wkup_m3_copy_data(am33xx_i2c_wake_sequence,
>> +                                             i2c_wake_sequence_sz);
>> +             /* Upper 16 bits stores offset to wake sequence */
>> +             param4 &= ~0xffff0000;
>> +             param4 |= pos << 16;
>> +     }
>> +
>
> Seems above entire change can be done only once.
>
>>       am33xx_pm->ipc.sleep_mode       = IPC_CMD_DS0;
>>       am33xx_pm->ipc.param1           = DS_IPC_DEFAULT;
>>       am33xx_pm->ipc.param2           = DS_IPC_DEFAULT;
>> +     am33xx_pm->ipc.param4           = param4;
>>
>>       am33xx_pm_ipc_cmd(&am33xx_pm->ipc);
>>
>> @@ -386,6 +413,62 @@ static int __init am33xx_map_emif(void)
>>       return 0;
>>  }
>>
>> +static int __init am33xx_setup_sleep_sequence(void)
>> +{
>> +     int ret;
>> +     int sz;
>> +     const void *prop;
>> +     struct device *dev;
>> +     u32 freq_hz = 100000;
>
> Magic number?

It's taken from drivers/i2c/busses/i2c-omap.c

    u32 freq = 100000; /* default to 100000 Hz */

I'll add a comment to that effect.

>> +     unsigned short freq_khz;
>> +
>> +     /*
>> +      * We put the device tree node in the I2C controller that will
>> +      * be sending the sequence. i2c1 is the only controller that can
>> +      * be accessed by the firmware as it is the only controller in the
>> +      * WKUP domain.
>
> and on which the PMIC sits I believe?

Yes, but this code is designed not to be PMIC specific as one could
chose to regulate VDD_CORE with any PMIC, or even with a standalone
I2C controlled regulator.

>> +      */
>> +     dev = omap_device_get_by_hwmod_name("i2c1");
>> +     if (IS_ERR(dev))
>> +             return PTR_ERR(dev);
>> +
>> +     of_property_read_u32(dev->of_node, "clock-frequency", &freq_hz);
>> +     freq_khz = freq_hz / 1000;
>
> Magic number?

Nah, converting between metric prefixes this way is pretty common in the kernel.

>> +
>> +     prop = of_get_property(dev->of_node, "sleep_sequence", &sz);
>> +     if (prop) {
>> +             /*
>> +              * Length is sequence length + 2 bytes for freq_khz, and 1
>> +              * byte for terminator.
>> +              */
>> +             am33xx_i2c_sleep_sequence = kzalloc(sz + 3, GFP_KERNEL);
>> +             if (!am33xx_i2c_sleep_sequence)
>> +                     return -ENOMEM;
>> +             put_unaligned_le16(freq_khz, am33xx_i2c_sleep_sequence);
>> +             memcpy(am33xx_i2c_sleep_sequence + 2, prop, sz);
>
> so, looking at entire code, it seems there is 3 memory space for same
> data (or 1 original + 2 copy)
>
> 1. in DT
> 2. in am33xx_i2c_[sleep/wake]_sequence
> 3. in SRAm by call to wkup_m3_copy_data()
>
> why not directly copy to SRAM from DT?

As pointed out above, the firmware reset handler would wipe it out.

>> +             i2c_sleep_sequence_sz = sz + 3;
>> +     }
>> +
>> +     prop = of_get_property(dev->of_node, "wake_sequence", &sz);
>> +     if (prop) {
>> +             am33xx_i2c_wake_sequence = kzalloc(sz + 3, GFP_KERNEL);
>> +             if (!am33xx_i2c_wake_sequence) {
>> +                     ret = -ENOMEM;
>> +                     goto cleanup_sleep;
>> +             }
>> +             put_unaligned_le16(freq_khz, am33xx_i2c_sleep_sequence);
>> +             memcpy(am33xx_i2c_wake_sequence + 2, prop, sz);
>> +             i2c_wake_sequence_sz = sz + 3;
>> +     }
>> +
>> +     return 0;
>> +
>> +cleanup_sleep:
>> +     kfree(am33xx_i2c_sleep_sequence);
>> +     am33xx_i2c_sleep_sequence = NULL;
>> +     return ret;
>> +}
>> +
>>  int __init am33xx_pm_init(void)
>>  {
>>       int ret;
>> @@ -451,6 +534,12 @@ int __init am33xx_pm_init(void)
>>               }
>>       }
>>
>> +     ret = am33xx_setup_sleep_sequence();
>> +     if (ret) {
>> +             pr_err("Error fetching I2C sleep/wake sequence\n");
>> +             goto err;
>> +     }
>> +
>>       (void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
>>
>>       /* CEFUSE domain can be turned off post bootup */
>> diff --git a/arch/arm/mach-omap2/pm33xx.h b/arch/arm/mach-omap2/pm33xx.h
>> index befdd11..d0f08a5 100644
>> --- a/arch/arm/mach-omap2/pm33xx.h
>> +++ b/arch/arm/mach-omap2/pm33xx.h
>> @@ -52,6 +52,8 @@ struct forced_standby_module {
>>  };
>>
>>  int wkup_m3_copy_code(const u8 *data, size_t size);
>> +void wkup_m3_reset_data_pos(void);
>> +int wkup_m3_copy_data(const u8 *data, size_t size);
>>  int wkup_m3_prepare(void);
>>  void wkup_m3_register_txev_handler(void (*txev_handler)(void));
>>
>> diff --git a/arch/arm/mach-omap2/wkup_m3.c b/arch/arm/mach-omap2/wkup_m3.c
>> index 8eaa7f3..a541de9 100644
>> --- a/arch/arm/mach-omap2/wkup_m3.c
>> +++ b/arch/arm/mach-omap2/wkup_m3.c
>> @@ -35,6 +35,9 @@
>>  struct wkup_m3_context {
>>       struct device   *dev;
>>       void __iomem    *code;
>> +     void __iomem    *data;
>> +     void __iomem    *data_end;
>> +     size_t          data_size;
>>       void (*txev_handler)(void);
>>  };
>>
>> @@ -50,6 +53,30 @@ int wkup_m3_copy_code(const u8 *data, size_t size)
>>       return 0;
>>  }
>>
>> +/*
>> + * This pair of functions allows data to be stuffed into the end of the
>> + * CM3 data memory. This is currently used for passing the I2C sleep/wake
>> + * sequences to the firmware.
>> + */
>> +
>> +/* Clear out the pointer for data stored at the end of DMEM */
>> +void wkup_m3_reset_data_pos(void)
>> +{
>> +     wkup_m3->data_end = wkup_m3->data + wkup_m3->data_size;
>> +}
>> +
>> +/*
>> + * Store a block of data at the end of DMEM, return the offset within DMEM
>> + * that the data is stored at, or -ENOMEM if the data did not fit
>> + */
>> +int wkup_m3_copy_data(const u8 *data, size_t size)
>> +{
>> +     if (wkup_m3->data + size > wkup_m3->data_end)
>> +             return -ENOMEM;
>> +     wkup_m3->data_end -= size;
>> +     memcpy_toio(wkup_m3->data_end, data, size);
>> +     return wkup_m3->data_end - wkup_m3->data;
>> +}
>>
>>  void wkup_m3_register_txev_handler(void (*txev_handler)(void))
>>  {
>> @@ -83,7 +110,7 @@ int wkup_m3_prepare(void)
>>  static int wkup_m3_probe(struct platform_device *pdev)
>>  {
>>       int irq, ret = 0;
>> -     struct resource *mem;
>> +     struct resource *umem, *dmem;
>>
>>       pm_runtime_enable(&pdev->dev);
>>
>> @@ -95,14 +122,21 @@ static int wkup_m3_probe(struct platform_device *pdev)
>>
>>       irq = platform_get_irq(pdev, 0);
>>       if (!irq) {
>> -             dev_err(wkup_m3->dev, "no irq resource\n");
>> +             dev_err(&pdev->dev, "no irq resource\n");
>
> unrelated change?. Better to mention this as code cleanup in commit.

Will add a comment to that effect, the underlying error should be
fixed in the next suspend/resume patch though.

>> +             ret = -ENXIO;
>> +             goto err;
>> +     }
>> +
>> +     umem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!umem) {
>> +             dev_err(&pdev->dev, "no UMEM resource\n");
>>               ret = -ENXIO;
>>               goto err;
>>       }
>>
>> -     mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -     if (!mem) {
>> -             dev_err(wkup_m3->dev, "no memory resource\n");
>> +     dmem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +     if (!dmem) {
>> +             dev_err(&pdev->dev, "no DMEM resource\n");
>>               ret = -ENXIO;
>>               goto err;
>>       }
>> @@ -116,12 +150,21 @@ static int wkup_m3_probe(struct platform_device *pdev)
>>
>>       wkup_m3->dev = &pdev->dev;
>>
>> -     wkup_m3->code = devm_request_and_ioremap(wkup_m3->dev, mem);
>> +     wkup_m3->code = devm_request_and_ioremap(wkup_m3->dev, umem);
>> +     if (!wkup_m3->code) {
>> +             dev_err(wkup_m3->dev, "could not ioremap UMEM\n");
>
> why not use "pdev->dev" here?

Either one works

>> +             ret = -EADDRNOTAVAIL;
>> +             goto err;
>> +     }
>> +
>> +     wkup_m3->data = devm_request_and_ioremap(wkup_m3->dev, dmem);
>>       if (!wkup_m3->code) {
>
> I believe this is just a copy/paste error. s/code/data

Doh, thanks!

>> -             dev_err(wkup_m3->dev, "could not ioremap\n");
>> +             dev_err(wkup_m3->dev, "could not ioremap DMEM\n");
>
> same as above.
>
>>               ret = -EADDRNOTAVAIL;
>>               goto err;
>>       }
>> +     wkup_m3->data_size = resource_size(dmem);
>> +     wkup_m3_reset_data_pos();
>>
>>       ret = devm_request_irq(wkup_m3->dev, irq, wkup_m3_txev_handler,
>>                 IRQF_DISABLED, "wkup_m3_txev", NULL);
>> -- 1.8.3.2 -- To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in the body of a message to majordomo@vger.kernel.org More
>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
