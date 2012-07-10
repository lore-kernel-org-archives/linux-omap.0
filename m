From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v1 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
Date: Tue, 10 Jul 2012 12:35:35 +0530
Message-ID: <4FFBD43F.4010704@ti.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>	<1340884267-28908-2-git-send-email-kishon@ti.com>	<4FFBC1D0.5030506@ti.com>	<D958900912E20642BCBC71664EFECE3E6DDAD9FF96@BGMAIL02.nvidia.com> <CAAe_U6Kx8o6sHgpev3UEAou7tuNDt9iL0+hcyOVDb0WsCsSwKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAAe_U6Kx8o6sHgpev3UEAou7tuNDt9iL0+hcyOVDb0WsCsSwKg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: Venu Byravarasu <vbyravarasu@nvidia.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "balbi@ti.com" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "hvaibhav@ti.com" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 July 2012 12:18 PM, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>
> On Tue, Jul 10, 2012 at 11:33 AM, Venu Byravarasu
> <vbyravarasu@nvidia.com>  wrote:
>>>> +
>>>> +#ifdef CONFIG_PM
>>
>> Should it not be CONFIG_PM_SLEEP instead of just CONFIG_PM?
>
> Why? I think we should have CONFIG_PM_SLEEP only when we have
> *suspend*, *resume* hooks. But this driver has only *runtime_suspend*
> and *runtime_resume* hooks.

CONFIG_PM_RUNTIME maybe then?
