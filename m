From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 4/4] mfd: global Suspend and resume support of ehci and ohci
Date: Wed, 1 Jun 2011 19:08:49 +0530
Message-ID: <BANLkTimo8mF43SuyLAzdu18fD2di1Gurmw@mail.gmail.com>
References: <1306934847-6098-1-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-2-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-3-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-4-git-send-email-keshava_mgowda@ti.com>
	<1306934847-6098-5-git-send-email-keshava_mgowda@ti.com>
	<20110601133128.GD2409@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110601133128.GD2409@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 1, 2011 at 7:01 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Jun 01, 2011 at 06:57:27PM +0530, Keshava Munegowda wrote:
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 43de12a..32d19e2 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -146,6 +146,10 @@
>> =A0#define is_ehci_hsic_mode(x) (x =3D=3D OMAP_EHCI_PORT_MODE_HSIC)
>>
>>
>> +/* USBHS state bits */
>> +#define OMAP_USBHS_INIT =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define OMAP_USBHS_SUSPEND =A0 4
>
> #define OMAP_USBHS_INIT =A0 =A0 =A0 =A0 BIT(0)
> #define OMAP_USBHS_SUSPEND =A0 =A0 =A0BIT(1)
>
> ???

yes, I will do.. please comment on other patches too

keshava
