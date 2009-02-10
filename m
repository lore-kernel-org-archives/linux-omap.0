From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/1] Group and resource assignments for TWL4030
Date: Tue, 10 Feb 2009 15:28:18 +0200
Message-ID: <20090210132818.GM3166@scadufax.research.nokia.com>
References: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com> <1234271495-11705-2-git-send-email-peter.de-schrijver@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37350 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbZBJNnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 08:43:01 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1ADgb5e032515
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 15:42:59 +0200
Content-Disposition: inline
In-Reply-To: <1234271495-11705-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Feb 10, 2009 at 02:11:35PM +0100, Peter 'p2' De Schrijver wrote:
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  drivers/mfd/twl4030-power.c |   95 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/i2c/twl4030.h |   41 ++++++++++++++++++-
>  2 files changed, 134 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index d9d1655..c558127 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -38,6 +38,8 @@ static u8 triton_next_free_address = 0x2b;
>  #define PHY_TO_OFF_PM_MASTER(p)                (p - 0x36)
>  #define PHY_TO_OFF_PM_RECEIVER(p)      (p - 0x5b)
> 
> +#define NUM_OF_RESOURCES       28
> +
>  /* resource - hfclk */
>  #define R_HFCLKOUT_DEV_GRP     PHY_TO_OFF_PM_RECEIVER(0xe6)
> 
> @@ -66,6 +68,42 @@ static u8 triton_next_free_address = 0x2b;
>  #define KEY_1                  0xC0
>  #define KEY_2                  0x0C
> 
> +/* resource configuration registers */
> +
> +#define DEVGROUP_OFFSET                0
> +#define TYPE_OFFSET            1
> +
> +static int __initdata res_config_addrs[] = {
> +       [1] = 0x17,
> +       [2] = 0x1b,
> +       [3] = 0x1f,
> +       [4] = 0x23,
> +       [5] = 0x27,
> +       [6] = 0x2b,
> +       [7] = 0x2f,
> +       [8] = 0x33,
> +       [9] = 0x37,
> +       [10] = 0x3b,
> +       [11] = 0x3f,
> +       [12] = 0x43,
> +       [13] = 0x47,
> +       [14] = 0x4b,
> +       [15] = 0x55,
> +       [16] = 0x63,
> +       [17] = 0x71,
> +       [18] = 0x74,
> +       [19] = 0x77,
> +       [20] = 0x7a,
> +       [21] = 0x7f,
> +       [22] = 0x82,
> +       [23] = 0x85,
> +       [24] = 0x88,
> +       [25] = 0x8b,
> +       [26] = 0x8e,
> +       [27] = 0x91,
> +       [28] = 0x94,
> +};
> +
>  static int __init twl4030_write_script_byte(u8 address, u8 byte)
>  {
>         int err;
> @@ -245,10 +283,57 @@ static int __init load_triton_script(struct twl4030_script *tscript)
>         return err;
>  }
> 
> +static void __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
> +{
> +       int rconfig_addr;
> +       u8 type;
> +
> +       if (rconfig->resource > NUM_OF_RESOURCES) {
> +               printk(KERN_ERR
> +                       "TWL4030 Resource %d does not exist\n",
> +                       rconfig->resource);
> +               return;
> +       }
> +
> +       rconfig_addr = res_config_addrs[rconfig->resource];
> +
> +       /* Set resource group */
> +
> +       if (rconfig->devgroup >= 0)
> +               twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                                       rconfig->devgroup << 5,
> +                                       rconfig_addr + DEVGROUP_OFFSET);
> +
> +       /* Set resource types */
> +
> +       if (twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
> +                                       &type,
> +                                       rconfig_addr + TYPE_OFFSET) < 0) {
> +               printk(KERN_ERR
> +                       "TWL4030 Resource %d type could not read\n",
> +                       rconfig->resource);
> +               return;
> +       }
> +
> +       if (rconfig->type >= 0) {
> +               type &= ~7;
> +               type |= rconfig->type;
> +       }
> +
> +       if (rconfig->type2 >= 0) {
> +               type &= ~(3 << 3);
> +               type |= rconfig->type2 << 3;
> +       }
> +
> +       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                               type, rconfig_addr + TYPE_OFFSET);
> +}
> +
>  void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
>  {
>         int err = 0;
>         int i;
> +       struct twl4030_resconfig *resconfig;
> 
>         err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_1,
>                                 R_PROTECT_KEY);
> @@ -258,12 +343,20 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
>                 printk(KERN_ERR
>                         "TWL4030 Unable to unlock registers\n");
> 
> -       for (i = 0; i < triton2_scripts->size; i++) {
> +       for (i = 0; i < triton2_scripts->scripts_size; i++) {
>                 err = load_triton_script(triton2_scripts->scripts[i]);
>                 if (err)
>                         break;
>         }
> 
> +       resconfig = triton2_scripts->resource_config;
> +       if (resconfig) {
> +               while (resconfig->resource) {
> +                       twl4030_configure_resource(resconfig);
> +                       resconfig++;
> +               }
> +       }
> +
>         if (twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY))
>                 printk(KERN_ERR
>                         "TWL4030 Unable to relock registers\n");
> diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> index 93d483d..e6ce1cd 100644
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -243,6 +243,37 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
>  #define RES_STATE_SLEEP                0x8
>  #define RES_STATE_OFF          0x0
> 
> +/* Power resources */
> +
> +#define RES_VAUX1              1
> +#define RES_VAUX2              2
> +#define RES_VAUX3              3
> +#define RES_VAUX4              4
> +#define RES_VMMC1              5
> +#define RES_VMMC2              6
> +#define RES_VPLL1              7
> +#define RES_VPLL2              8
> +#define RES_VSIM               9
> +#define RES_VDAC               10
> +#define RES_VINTANA1           11
> +#define RES_VINTANA2           12
> +#define RES_VINTDIG            13
> +#define RES_VIO                        14
> +#define RES_VDD1               15
> +#define RES_VDD2               16
> +#define RES_VUSB_1v5           17
> +#define RES_VUSB_1v8           18
> +#define RES_VUSB_3v1           19
> +#define RES_VUSBCP             20
> +#define RES_REGEN              21
> +#define RES_NRES_PWRON         22
> +#define RES_CLKEN              23
> +#define RES_SYSEN              24
> +#define RES_HFCLKOUT           25
> +#define RES_32KCLKOUT          26
> +#define RES_RESET              27
> +#define RES_Main_Ref           28

These are not being used anywhere, I guess you wanted to use them in the
array in the beginning of the patch ??

-- 
balbi
