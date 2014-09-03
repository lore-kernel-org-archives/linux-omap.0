From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: Re: [PATCH 4/5] usb: dwc3: Adding Kconfig dependency for Exynos7
Date: Wed, 3 Sep 2014 09:23:55 +0530
Message-ID: <CAFp+6iExPJf8bfzG9DjXo1Jwr4maqj0C9x_WNwXiSyTcubDAZg@mail.gmail.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
	<1409212920-28526-5-git-send-email-gautam.vivek@samsung.com>
	<20140828192824.GR16689@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140828192824.GR16689@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, kishon <kishon@ti.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 29, 2014 at 12:58 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Aug 28, 2014 at 01:31:59PM +0530, Vivek Gautam wrote:
>> The Exynos-DWC3 USB 3.0 DRD controller is also present on
>> Exynos7 platform, so adding the dependency on ARCH_EXYNOS7
>> for this driver.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> ---
>>  drivers/usb/dwc3/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>> index 785510a..e235894 100644
>> --- a/drivers/usb/dwc3/Kconfig
>> +++ b/drivers/usb/dwc3/Kconfig
>> @@ -55,7 +55,7 @@ config USB_DWC3_OMAP
>>
>>  config USB_DWC3_EXYNOS
>>       tristate "Samsung Exynos Platform"
>> -     depends on ARCH_EXYNOS || COMPILE_TEST
>> +     depends on (ARCH_EXYNOS || ARCH_EXYNOS7) || COMPILE_TEST
>
> wait when building for ARCH_EXYNOS7 you don't get ARCH_EXYNOS ?

Right, we do get it now in V2 patch series for Exynos7 [1],
but it wasn't available in the first series [2].
Will drop this patch now.

[1] http://www.spinics.net/lists/linux-samsung-soc/msg36378.html
[2] http://www.spinics.net/lists/arm-kernel/msg357382.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
