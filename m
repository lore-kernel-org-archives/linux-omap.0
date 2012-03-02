From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: wait for RXDET before putting phy in TX_ON
Date: Fri, 2 Mar 2012 16:55:28 +0530
Message-ID: <CAP5A+B_=Jr+iQourN__8Jaek7sR_PUOK_OCQ88q0Y7gaNzE4WA@mail.gmail.com>
References: <1330589664-15755-1-git-send-email-mythripk@ti.com>
 <1330601462.2586.32.camel@deskari> <CAP5A+B8uqQYq671=TQRm0LsYSfdDMoZY0koU4JH=MpA20HMj2w@mail.gmail.com>
 <1330685544.2184.7.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:45664 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964794Ab2CBLZt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 06:25:49 -0500
Received: by obqv19 with SMTP id v19so2017653obq.6
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 03:25:48 -0800 (PST)
In-Reply-To: <1330685544.2184.7.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

>> Damage never happens with the cable connected for a long time.. Dama=
ge
>> happens only
>> when the cable is connected when the PHY is in TX ON state. Which
>> requires the following sequence to be followed.
>> 1. Wait for HPD connect
>> 2. Wait for the PHY connect ( TMDS lines are up)
>> 3. Enable PHY
>> We are currently missing step 2.
>
> Doesn't HPD already tell us that the cable is connected?
>
Yes HPD tells us that cable is connected but does not guarantee that
the line is ready for transmission of data, HPD just means the DDC
line is up.
>> I am not very sure which TRM you have but the HDMI_WP_WP_DEBUG_DATA
>> can also be used to probe the TMDS lines as well, but i might as wel=
l
>> try pad config and let you know.
>
> I have 4460 HDMI TRM vF and 4430 HDMI TRM vL. Both look the same
> regarding the debug registers. Can you send me the latest ones that
> explain the DEBUG registers correctly?
sure.
>

>> > In the worst case the above causes a 7.5ms busy loop in an interru=
pt
>> > handler. That's not very good thing. Why is there a need for the l=
oop?
>> I agree looping in interrupt context is bad.. That was the reason i
>> had a threaded irq handler and i case even here it is the threaded i=
rq
>> handler i dont think it is happening in irq context.
>
> We should nevertheless avoid 7.5ms busyloop if at all possible. Is th=
ere
> an estimate of how long it takes for the PHY to connect? I think we
> could just start a delayed work from the interrupt, and do the check
> after a short delay. I don't think the user cares if the connect happ=
ens
> after 1ms or 10ms from the moment the cable is plugged in =3D).
>
Actually by using the PHY_CONNECT interrupt we can avoid the wait.
If the TV channel is the same as the HDMI port connected to then there
is hardly any delay between HPD and TMDS lines. Problem is when user
connects to HDMI but is running  say AV1 /AV2  on TV.
In such case we will see that HPD is high but TMDS lines are low, So
there is no guarantee it will be done in certain period, as it is user
dependent.
So i am more inclined to have a interrupt based way, On receiving HPD
in the threaded irq handler we can wait_on_completion of PHY_CONNECT
which will put the thread in sleep until TMDS lines are high.
I shall make that patch test out and post it soon.

Thanks and regards,
Mythri.

> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
