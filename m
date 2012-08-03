From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] OMAP4: otg: phy: fix charger detection
Date: Fri, 3 Aug 2012 16:35:51 +0300
Message-ID: <CAEa47NrvDvL=DLT2Qs4k9fZpW=98WZDg+zJwrt6qgtRO0oC=+g@mail.gmail.com>
References: <1341477720-6771-1-git-send-email-ruslan.bilovol@ti.com>
	<CAAe_U6+w8VbYcCXDZ6wPzu4hrF-MSpXdArz6nogPbfZ0m2E=Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAe_U6+w8VbYcCXDZ6wPzu4hrF-MSpXdArz6nogPbfZ0m2E=Ag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Aug 3, 2012 at 12:01 PM, ABRAHAM, KISHON VIJAY <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Thu, Jul 5, 2012 at 2:12 PM, Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org> wrote:
>> Charger detection feature is not correctly used
>> and thus makes some regressions if OTG was used in
>> the host mode. Charger detection takes 500 ms so
>> if some device is attached to the host after 500 ms
>> it will be suddenly resetted.
>>
>> This feature is enabled by default after reset/cold boot
>> so always affects PHY usage. So finally this was wrongly
>> interpreted as "phy requires 200ms to start".
>> After fixing this we can safely remove uggly mdelay after
>> powering on the PHY.
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/mach-omap2/omap_phy_internal.c |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
>> index d52651a..a13a37c 100644
>> --- a/arch/arm/mach-omap2/omap_phy_internal.c
>> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
>> @@ -42,12 +42,16 @@
>>  #define        SESSEND                         BIT(3)
>>  #define        IDDIG                           BIT(4)
>>
>> +#define CONTROL_USB2PHYCORE            0x620
>> +#define USB2PHY_DISCHGDET              BIT(30)
>> +
>>  static struct clk *phyclk, *clk48m, *clk32k;
>>  static void __iomem *ctrl_base;
>>  static int usbotghs_control;
>>
>>  int omap4430_phy_init(struct device *dev)
>>  {
>> +       u32 usb2phycore;
>>         ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>>         if (!ctrl_base) {
>>                 pr_err("control module ioremap failed\n");
>> @@ -56,6 +60,11 @@ int omap4430_phy_init(struct device *dev)
>>         /* Power down the phy */
>>         __raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>>
>> +       /* Disable charger detection by default */
>> +       usb2phycore = omap4_ctrl_pad_readl(CONTROL_USB2PHYCORE);
>> +       usb2phycore |= USB2PHY_DISCHGDET;
>> +       omap4_ctrl_pad_writel(usb2phycore, CONTROL_USB2PHYCORE);
>
> Maybe I failed to understand correctly but the $subject says it
> *fixes* charger detection but the patch *disables* charger detection.
>

Yes, you are correct (the patch originally was done for case with
charger detection realized)

Will submit new patchsets with fixed subject and description

--
Best regards,
Ruslan Bilovol
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
