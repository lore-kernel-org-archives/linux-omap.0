From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Wed, 2 May 2012 12:50:12 +0200
Message-ID: <A53CAEEE-E425-46B7-8E7B-B4AFB163ECAC@dominion.thruhere.net>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com> <CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com> <CA+Bv8XZeCTV2kr_d7dEAeEthwD0TkNZPiEV5m-iOFjoX7xur9Q@mail.gmail.com> <CAMrsUdL18b2Ox3CkzuNjQQW1JT1+-SAso67EkrwE-BTJbavYPA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMrsUdL18b2Ox3CkzuNjQQW1JT1+-SAso67EkrwE-BTJbavYPA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Raja, Govindraj" <govindraj.raja-l0cyMroinI0@public.gmane.org>
Cc: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Op 2 mei 2012, om 12:38 heeft Raja, Govindraj het volgende geschreven:

> On Wed, May 2, 2012 at 2:17 PM, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org> wrote:
>> On Mon, Mar 19, 2012 at 6:34 AM, Raja, Govindraj <govindraj.raja-l0cyMroinI0@public.gmane.org> wrote:
>>> On Mon, Mar 19, 2012 at 12:12 PM, Keshava Munegowda
>>> <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
>>>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>>> 
>>>> It is observed that the echi ports of 3430 sdp board
>>>> are not working due to the random timing of programming
>>>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>>>> If the PHYs are reset at during usbhs core driver, host ports will
>>>> not work because EHCI driver is loaded after the resetting PHYs.
>>>> The PHYs should be in reset state while initializing the EHCI
>>>> controller.
>>>> The code which does the GPIO pins associated with the PHYs
>>>> are programmed to reset is moved from the USB host core driver
>>>> to EHCI driver.
>>> 
>>> I tested on beagle xm where gpio nreset is requested from
>>> board file.
>>> (Basic enumertaion after gpio nreset seems to work fine,
>>> Hub and smsc lan chip get detected afetr boot up)
>>> 
>> 
>> What base did you test this on top of? my xM is failing USB-wise when
>> I apply this on v3.3.3 (with the UART mux fix patch) and where it is
>> applied within master (3.4-rc4, again, with the UART mux fix patch).
>> Additionally, reverting this patch from 3.4-rc5 causes rc5 to work
>> properly.
>> 
> 
> Works for me be on 3.4-rc5 Beagle-XM even without reverting the patch
> 
> Logs as in here [1].

>From your log:

[    1.705291] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.726593] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller

Why is the ehci stuff taking more than 2 seconds?

regards,

Koen--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
