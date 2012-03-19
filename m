From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Mon, 19 Mar 2012 11:48:22 +0530
Message-ID: <CAP05o4JdP3Hn6QqVLF-CfeXUXfebUuyLN6eKYnUbJMxGoMgH+w@mail.gmail.com>
References: <1330077975-31694-1-git-send-email-keshava_mgowda@ti.com>
	<20120224101632.GL17178@legolas.emea.dhcp.ti.com>
	<CAP05o4KRUp_W1yXn29TATMDOwMVbX_pWt6iKrrb=2jkOuWij+A@mail.gmail.com>
	<CAP05o4J1BYN2WkJToswcp4ofagp2mOuPmwWeMfJRwrfS_xEe0Q@mail.gmail.com>
	<CAP05o4KDYqcU+TbMouQGsMaLUjZsJ7G+Anp9RcvUKuoFqQab3g@mail.gmail.com>
	<20120316162022.GA20524@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120316162022.GA20524@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 16, 2012 at 9:50 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> w=
rote:
> Hi Keshava,
>
> On Thu, Mar 08, 2012 at 08:30:21PM +0530, Munegowda, Keshava wrote:
>> On Fri, Mar 2, 2012 at 7:36 PM, Munegowda, Keshava
>> <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
>> > On Fri, Feb 24, 2012 at 5:14 PM, Munegowda, Keshava
>> > <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
>> >> On Fri, Feb 24, 2012 at 3:46 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrot=
e:
>> >>> Hi,
>> >>>
>> >>> On Fri, Feb 24, 2012 at 03:36:15PM +0530, Keshava Munegowda wrot=
e:
>> >>>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >>>>
>> >>>> It is observed that the echi ports of 3430 sdp board
>> >>>> are not working due to the random timing of programming
>> >>>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>> >>>> If the PHYs are reset at during usbhs core driver, host ports w=
ill
>> >>>> not work because EHCI driver is loaded after the resetting PHYs=
=2E
>> >>>> The PHYs should be in reset state while initializing the EHCI
>> >>>> controller.
>> >>>> The code which does the GPIO pins associated with the PHYs
>> >>>> are programmed to reset is moved from the USB host core driver
>> >>>> to EHCI driver.
>> >>>>
>> >>>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >>>> Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
>> >>>
>> >>> won't this cause issues with EHCI/OHCI interactions ? I mean, wh=
at if
>> >>> you connect a FS/LS device and port is handed over to OHCI, does=
 OHCI
>> >>> have any needs to reset the PHY or something similar ?
>> >>
>> >> No, it will not cause any issues with EHCI-OHCI issues.
>> >> But its difficult to comment on this because we don't have port
>> >> handoff supported
>> >> in hardware.
>> >>
>> >> regards
>> >> keshava
>> >
>> > Hi Samuel
>> > =A0 =A0 =A0 =A0please let me know if you have any comments on this=
 patch.
>> > This is required patch for omap3 ehci enumeration instabilities.
>> >
>> > Regards
>> > Keshava
>>
>> Hi Samuel
>> =A0 =A0 =A0 do you have any comments on this patch?
> I actually never received the actual patch, I think.
>
>
>> Felipe has reviewed this patch and he is agreed for this patch.
>> there are no comments from your side, requesting to push this change
>> to mainline.
> I looked at it on gmame, and it seems fine to me. If you want me to p=
ush this
> patch, then please (re-)send it to me, even privately.
>
> Cheers,
> Samuel.
>

Thanks Samuel
           yes, I will resend this ASAP.


regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
