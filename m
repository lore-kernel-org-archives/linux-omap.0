From: joseph daniel <josephdanielwalter@gmail.com>
Subject: Re: [PATCH] usb/dwc3: Fix the dwc3 dependency
Date: Fri, 11 May 2012 15:39:10 +0530
Message-ID: <CAFDqYy02=wMSqtXxsU0c+sZL++1BPvUz4yMEfGthzGr98O5=xw@mail.gmail.com>
References: <1336715724-8441-1-git-send-email-josephdanielwalter@gmail.com>
	<20120511075713.GA14284@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120511075713.GA14284@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Fri, May 11, 2012 at 1:27 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, May 11, 2012 at 11:25:24AM +0530, joseph daniel wrote:
>> The warning shown up when ran with randconfig,
>>
>> warning: (USB_DWC3) selects USB_XHCI_PLATFORM which has unmet direct=
 dependencies (USB_SUPPORT && USB_XHCI_HCD)
>>
>> Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
>> ---
>> =A0drivers/usb/dwc3/Kconfig | =A0 =A02 +-
>> =A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>> index d8f741f..68271fa 100644
>> --- a/drivers/usb/dwc3/Kconfig
>> +++ b/drivers/usb/dwc3/Kconfig
>> @@ -1,6 +1,6 @@
>> =A0config USB_DWC3
>> =A0 =A0 =A0 tristate "DesignWare USB3 DRD Core Support"
>> - =A0 =A0 depends on (USB && USB_GADGET)
>> + =A0 =A0 depends on (USB && USB_SUPPORT && USB_XCHI_HCD && USB_GADG=
ET)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0^^^^
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0typo
>
> I would prefer the select to change:
>
> select XHCI_PLATFORM if (USB_SUPPORT && USB_XHCI_HCD)
>
will do this and send out a patch shotly.
> or something similar.
>
>> =A0 =A0 =A0 select USB_OTG_UTILS
>> =A0 =A0 =A0 select USB_GADGET_DUALSPEED
>> =A0 =A0 =A0 select USB_GADGET_SUPERSPEED
>
> --
> balbi

Thanks
