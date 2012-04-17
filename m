From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Tue, 17 Apr 2012 12:00:35 +0530
Message-ID: <CAP05o4+ifjccMqVdu_EDYpY=_=OvGr+57XYpQfnOofHXbN+-sA@mail.gmail.com>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
	<4F71D87E.70100@compulab.co.il>
	<CAP05o4JWjoh-NoDeA3vYaS1yY_SGdm3TZvHA=pkQsP-Xo-kWnQ@mail.gmail.com>
	<20120416164646.GP24130@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120416164646.GP24130@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 16, 2012 at 10:16 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> =
wrote:
> Hi Keshava,
>
> On Wed, Apr 11, 2012 at 05:15:03PM +0530, Munegowda, Keshava wrote:
>> On Tue, Mar 27, 2012 at 8:40 PM, Igor Grinberg <grinberg-UTxiZqZC01TQFizaE/u3fw@public.gmane.org=
=2Eil> wrote:
>> > On 03/19/12 08:42, Keshava Munegowda wrote:
>> >> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >>
>> >> It is observed that the echi ports of 3430 sdp board
>> >> are not working due to the random timing of programming
>> >> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>> >> If the PHYs are reset at during usbhs core driver, host ports wil=
l
>> >> not work because EHCI driver is loaded after the resetting PHYs.
>> >> The PHYs should be in reset state while initializing the EHCI
>> >> controller.
>> >> The code which does the GPIO pins associated with the PHYs
>> >> are programmed to reset is moved from the USB host core driver
>> >> to EHCI driver.
>> >>
>> >> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >> Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
>> >
>> > Both EHCI ports worked on cm-t3730 previously and
>> > no regression is seen with this patch.
>> >
>> > Tested-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>> >
>> > --
>> > Regards,
>> > Igor.
>>
>> Hi sameo
>> =A0 =A0 =A0 =A0 =A0Since I am not seeing this patch in linux-next la=
bled 3.4.rc2
>> on 10th april 2012;
>> =A0please let me know your plan to queue this patch for the main lin=
e.
> I applied this one to my for-linus branch, thanks.
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/

Thank a lot Samuel

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
