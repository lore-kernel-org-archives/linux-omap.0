From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 5/5 v9] mfd: omap: usb: Runtime PM support
Date: Mon, 19 Sep 2011 11:35:12 +0530
Message-ID: <CAP05o4+KOns9a-u0GdCe1SK65eo61iee4d8zYJ6DzpT_wec2Hg@mail.gmail.com>
References: <1316092970-2440-1-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-2-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-3-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-4-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-5-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-6-git-send-email-keshava_mgowda@ti.com>
	<4E729AFB.6010008@am.sony.com>
	<CAP05o4JK9zdZ8P5o0Di+obDwYjur0p=TC-n9weznqx_odMzycw@mail.gmail.com>
	<CAP05o4JxUPBM=PqguRL8-Mvgyf=wgxvg7UWMcRo2WXe2jmCUVA@mail.gmail.com>
	<4E738B9A.3050908@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E738B9A.3050908@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
To: frank.rowand@am.sony.com
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "balbi@ti.com" <balbi@ti.com>, "gadiyar@ti.com" <gadiyar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@ti.com" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "vishwanath.bs@ti.com" <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 16, 2011 at 11:17 PM, Frank Rowand <frank.rowand@am.sony.co=
m> wrote:
> On 09/16/11 00:31, Munegowda, Keshava wrote:
>> On Fri, Sep 16, 2011 at 11:17 AM, Munegowda, Keshava
>> <keshava_mgowda@ti.com> wrote:
>>> On Fri, Sep 16, 2011 at 6:10 AM, Frank Rowand <frank.rowand@am.sony=
=2Ecom> wrote:
>>>> On 09/15/11 06:22, Keshava Munegowda wrote:
>>>>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>>>>
>>>>> The usbhs core driver does not enable/disable the interface and
>>>>> functional clocks; These clocks are handled by hwmod and runtime =
pm,
>>>>> hence instead of the clock enable/disable, the runtime pm APIS ar=
e
>>>>> used. however,the port clocks are handled by the usbhs core.
>>>>>
>>>>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>>>>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>>>>> ---
>>>>> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A03 -
>>>>> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 | =A0731 +++++=
++++++++--------------------
>>>>> =A0drivers/usb/host/ehci-omap.c =A0 =A0 =A0 =A0 =A0| =A0 17 +-
>>>>> =A0drivers/usb/host/ohci-omap3.c =A0 =A0 =A0 =A0 | =A0 18 +-
>>>>> =A04 files changed, 295 insertions(+), 474 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/pla=
t-omap/include/plat/usb.h
>>>>> index 17d3c93..2b66dc2 100644
>>>>
>>>> Patch 5/5 is white space mangled. =A0The tabs have been changed in=
to spaces.
>>>>
>>>> -Frank
>>>
>>
>> Hi Frank
>> =A0 =A0 =A0 =A0 =A0 I tried the checkpatch with --strict option; its=
 not showing
>> anything here. may be some problem with your editor/browser.
>
> It must be my email server, because when I pull the patch from an arc=
hive
> it has tabs. =A0Weird that only the fifth patch is being munged for m=
e...
>
> Thanks for checking!
>
> -Frank


Thanks Frank.

regards
keshava
