From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH v2 05/13] extcon: extcon-class: improve extcon client API
Date: Wed, 23 Apr 2014 09:33:26 +0200
Message-ID: <53576CC6.1010302@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
 <1397475984-28001-6-git-send-email-r.baldyga@samsung.com>
 <20140419105225.GB976@ambient.musicnaut.iki.fi> <53560A6F.8030909@samsung.com>
 <20140422150336.GA612@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20140422150336.GA612@drone.musicnaut.iki.fi>
Sender: linux-doc-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, m.szyprowski@samsung.com, t.figa@samsung.com
List-Id: linux-omap@vger.kernel.org

On 04/22/2014 05:03 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Apr 22, 2014 at 08:21:35AM +0200, Robert Baldyga wrote:
>> On 04/19/2014 12:52 PM, Aaro Koskinen wrote:
>>> On Mon, Apr 14, 2014 at 01:46:16PM +0200, Robert Baldyga wrote:
>>>>  	dev_info(&pdev->dev,
>>>> -		 "OMAP USB OTG controller rev %d.%d (%s, id=%d, vbus=%d)\n",
>>>> -		 (rev >> 4) & 0xf, rev & 0xf, config->extcon, otg_dev->id,
>>>> +		 "OMAP USB OTG controller rev %d.%d (id=%d, vbus=%d)\n",
>>>> +		 (rev >> 4) & 0xf, rev & 0xf, otg_dev->id,
>>>>  		 otg_dev->vbus);
>>>
>>> This change is unrelated to the patch and not needed.
>>>
>>
>> It's related because we no longer use config->extcon since we have
>> cable-oriented API. We can keep displaying it, but this value is
>> actually meaningless.
> 
> It's not completely meaningless, as the cable is searched using that name.
> 

Yes, I see, you're right. I have forgot that this driver doesn't use
devicetree. I will restore displaying extcon name.

Thanks!
Robert Baldyga
Samsung R&D Institute Poland

