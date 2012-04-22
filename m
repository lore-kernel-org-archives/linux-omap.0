From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Sun, 22 Apr 2012 09:36:27 +0300
Message-ID: <4F93A6EB.5050503@compulab.co.il>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com> <4F71D87E.70100@compulab.co.il> <CAP05o4JWjoh-NoDeA3vYaS1yY_SGdm3TZvHA=pkQsP-Xo-kWnQ@mail.gmail.com> <20120416164646.GP24130@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120416164646.GP24130@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On 04/16/12 19:46, Samuel Ortiz wrote:
> Hi Keshava,
> 
> On Wed, Apr 11, 2012 at 05:15:03PM +0530, Munegowda, Keshava wrote:
>> On Tue, Mar 27, 2012 at 8:40 PM, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> wrote:
>>> On 03/19/12 08:42, Keshava Munegowda wrote:
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
>>>>
>>>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>>> Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
>>>
>>> Both EHCI ports worked on cm-t3730 previously and
>>> no regression is seen with this patch.
>>>
>>> Tested-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>>>
>>> --
>>> Regards,
>>> Igor.
>>
>> Hi sameo
>>          Since I am not seeing this patch in linux-next labled 3.4.rc2
>> on 10th april 2012;
>>  please let me know your plan to queue this patch for the main line.
> I applied this one to my for-linus branch, thanks.

Since, you have already applied this patch to your tree,
can you please take also the [1] patch?
It has ackes from Felipe and Alan and depends on the patch in subj.

Thanks

[1] http://www.spinics.net/lists/linux-omap/msg67253.html

-- 
Regards,
Igor.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
