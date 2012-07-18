From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v2 02/11] arm/dts: omap: Add omap-usb2 dt data
Date: Wed, 18 Jul 2012 11:10:44 +0530
Message-ID: <CAAe_U6K1rXN3+YsbMo01kUUh-p=j7OBeMz-Kg_qADXjTbV2_Hg@mail.gmail.com>
References: <1342512611-20529-1-git-send-email-kishon@ti.com>
	<1342512611-20529-3-git-send-email-kishon@ti.com>
	<50055A21.5010206@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:38913 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751036Ab2GRFkp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 01:40:45 -0400
Received: by ghbg22 with SMTP id g22so1848338ghb.5
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 22:40:44 -0700 (PDT)
In-Reply-To: <50055A21.5010206@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

On Tue, Jul 17, 2012 at 5:57 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 17-07-2012 12:10, Kishon Vijay Abraham I wrote:
>
>> Add omap-usb2 data node in omap4 device tree file.
>
>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi |    5 +++++
>>   1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index bda5df3..4d2dcc1 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -279,6 +279,11 @@
>>                         #size-cells = <1>;
>>                         ranges;
>>                         ti,hwmods = "ocp2scp_usb_phy";
>> +                       usb2phy@0x4a0ad080 {
>
>
>    There should be no "0x" prefix here.

Ok. Will fix it.

Thanks
Kishon
