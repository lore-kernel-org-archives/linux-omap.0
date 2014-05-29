From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] sc_phy:SmartCard(SC) PHY interface to SC controller
Date: Thu, 29 May 2014 08:47:31 -0500
Message-ID: <CAL_Jsq+E7a=wh_yzQyaSEVAwfa34BYZ4DxvLOfJGFVDsf1dZ+A@mail.gmail.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
	<1401267437-22489-2-git-send-email-satish.patel@ti.com>
	<20140528185334.GA30763@kroah.com>
	<5386F0FE.7040003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5386F0FE.7040003-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 29, 2014 at 3:34 AM, Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org> wrote:
>
>
> On 5/29/2014 12:23 AM, Greg KH wrote:
>>
>> On Wed, May 28, 2014 at 02:27:13PM +0530, Satish Patel wrote:
>>>
>>> SmartCard controller uses this interface to communicate with
>>> SmartCard via PHY
>>>
>>> Some SmartCard PHY has multiple slots for cards.
>>> This inerface also enables controller to communicate
>>> with one or more SmartCard connected over phy.
>>>
>>> interface structure includes following APIs
>>> - set/get config
>>> - activate/deactivate smart card
>>> - warm reset
>>> - register_notify (for card insert/remove/overheat)
>>> - unregister_notify
>>>
>>> Signed-off-by: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   Documentation/sc_phy.txt |  171
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/sc_phy.h   |  136 ++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 307 insertions(+)
>>>   create mode 100644 Documentation/sc_phy.txt
>>>   create mode 100644 include/linux/sc_phy.h
>>
>>
>> These are .h files, but where is the "api" functions that use
>> these structures defined at?
>>
> This is like template/wrappers, smart card phy driver will write API
> functions. And smartcard controller will call these functions.
> With proposed approach, smartcard controller can communicate with any smart
> card phy (TI/NxP) without change in code. Using DT entry smartcard and PHY
> will gets connected with each other.
> Refer diagram given @Documentation/sc_phy.txt.
>
>
>> confused,

I believe the api Greg is wondering about is the notifier which as I
commented is not a good design.

There is now a phy subsystem. I don't know if it has what you need,
but you should look at it to determine if it will work or could be
extended to work.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
