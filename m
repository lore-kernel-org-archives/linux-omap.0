From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/3] ARM: dts: am335x: add support for Moxa UC-2101 open
 platform
Date: Tue, 18 Sep 2018 07:50:34 -0500
Message-ID: <2c14acd7-6443-f9c9-d2e4-c86544e39ff3@ti.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
 <20180830040929.23357-3-sz.lin@moxa.com>
 <47ebc8e6-b1cb-e040-8533-06eec05b4edd@ti.com>
 <TY2PR0101MB252666FF7718C84A4261682FE21E0@TY2PR0101MB2526.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY2PR0101MB252666FF7718C84A4261682FE21E0@TY2PR0101MB2526.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <SZ.Lin@moxa.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, =?UTF-8?B?V2VzIEh1YW5nICjpu4Pmt7XmsrMp?= <Wes.Huang@moxa.com>, =?UTF-8?B?RmVybyBKRCBaaG91ICjlkajkv4rpgZQp?= <FeroJD.Zhou@moxa.com>
List-Id: linux-omap@vger.kernel.org



On 09/17/2018 01:53 AM, SZ Lin (林上智) wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Grygorii Strashko [mailto:grygorii.strashko@ti.com]
> 
> <snip>
> 
>>
>> Pls, use phy-handle instead of phy_id here and in the next patch.
> 
> Thanks for the reminder, I will use phy-handle in next version.
> 
> Furthermore, the property of "phy-handle" doesn't work properly in 4.4.y-stable kernel.
> I've fixed it and sent the backport patches to 4.4.y-stable [1][2][3][4].
> 
> [1] https://www.spinics.net/lists/stable/msg256121.html
> [2] https://www.spinics.net/lists/stable/msg256124.html
> [3] https://www.spinics.net/lists/stable/msg256131.html
> [4] https://www.spinics.net/lists/stable/msg256749.html
> 

Thank you.

-- 
regards,
-grygorii
