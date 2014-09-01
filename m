From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: Re: [PATCH 3/5] phy: exynos5-usbdrd: Add facility for VBUS-BOOST-5V supply
Date: Mon, 1 Sep 2014 13:27:38 +0530
Message-ID: <CAFp+6iFrx6RJJjkuLpy+2RGsscpf2PXUATABJq8oPL+XhE_+vQ@mail.gmail.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
	<1409212920-28526-4-git-send-email-gautam.vivek@samsung.com>
	<20140828191625.GQ16689@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140828191625.GQ16689@saruman.home>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, kishon <kishon@ti.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,


On Fri, Aug 29, 2014 at 12:46 AM, Felipe Balbi <balbi@ti.com> wrote:
> hi,
>
> On Thu, Aug 28, 2014 at 01:31:58PM +0530, Vivek Gautam wrote:
>> @@ -457,11 +458,19 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
>>       clk_prepare_enable(phy_drd->ref_clk);
>>
>>       /* Enable VBUS supply */
>> +     if (phy_drd->vbus_boost) {
>> +             ret = regulator_enable(phy_drd->vbus_boost);
>> +             if (ret) {
>> +                     dev_err(phy_drd->dev,
>> +                             "Failed to enable VBUS boost supply\n");
>> +                     goto fail_vbus;
>> +             }
>> +     }
>
> really this is nitpicking, but can you add a blank line here just make
> my inner child happy ? :-)

Sure will add an extra line here and similar instances of this change.

>
>> @@ -470,6 +479,9 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
>>
>>       return 0;
>>
>> +fail_vbus_boost:
>> +     if (phy_drd->vbus_boost)
>> +             regulator_disable(phy_drd->vbus_boost);
>
> same here
>
> --
> balbi



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
