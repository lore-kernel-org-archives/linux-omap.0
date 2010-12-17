From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc handling
Date: Fri, 17 Dec 2010 12:43:12 -0600
Message-ID: <AANLkTimo=_hm7Atps8E0zkYUbP_kZtpz40FJbbMb0FVL@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
	<AANLkTi=RE3ZEuoe=jMRLiFZ7iVgvuXMrgqfXMAYa92=z@mail.gmail.com>
	<AANLkTinPpj5Po4yPjc8hG1Kjs2wM3b62-hRGMY+U_UjN@mail.gmail.com>
	<4D0B8FBB.5000906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59170 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755831Ab0LQSnN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 13:43:13 -0500
Received: by mail-gx0-f175.google.com with SMTP id 20so512264gxk.34
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 10:43:12 -0800 (PST)
In-Reply-To: <4D0B8FBB.5000906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Fri, Dec 17, 2010 at 10:28 AM, Cousson, Benoit <b-cousson@ti.com> wr=
ote:
>>>> =A0/* SYSCONFIG: register bit definition */
>>>> -#define AUTOIDLE =A0 =A0 =A0 (1<< =A00)
>>>> =A0#define SOFTRESET =A0 =A0 =A0(1<< =A01)
>>>> -#define SMARTIDLE =A0 =A0 =A0(2<< =A03)
>>>> =A0#define OMAP4_SOFTRESET =A0 =A0 =A0 =A0(1<< =A00)
>>>> -#define OMAP4_NOIDLE =A0 (1<< =A02)
>>>> -#define OMAP4_SMARTIDLE =A0 =A0 =A0 =A0(2<< =A02)
>>>>
>>>> =A0/* SYSSTATUS: register bit definition */
>>>> =A0#define RESETDONE =A0 =A0 =A0(1<< =A00)
>>>
>>> Is this still required?
>>
>> Yes, mailbox uses the softreset every time it is requested (and that
>> it has no current users at the time), it does it before configuring
>> sysc, as opossed to what this patch does (where clk is enabled, sysc
>> configured, and then softreset), but no harm was seen with this
>> sequence.
>>
>> AFAIK, enabling/disabling hwmod handles prm reset but not softreset
>> bit, that's why I left it there.
>
> In fact both are handled now. hardreset is managed for IVA, DSP and I=
PU, and
> softreset for most the other IPs.
> The only slight difference, is that softreset for the moment is just =
done
> once at setup time. The idea being that we do not know the state the
> bootloader configured IP, so we reset it by default.

Yes, I noticed that softreset was handled on setup only.

> I thought I did it for every enable from disable state, but in fact t=
his is
> not the case, because AFAIK there is not use-case for that yet.
>
> Why do you have to softreset the mailbox? That sounds like some old H=
W bugs
> from the past that we solve using the softreset.

It is adviced in the TRM that before initialization of the module, you
should do a softreset and set sysc register, I found this explanation
too (with git blame):

    omap: mailbox: Execute softreset at startup

    The softreset at startup is introduced as TRM describes and also so=
me
    register bit definitions are added instead of magic number

But mailbox doesn't execute this on init, but on every first user
request, it doesn't sound like there was a bug solved with this.

Also related (these were the quickest I could check):

- The DSI protocol engine can be reset by software. This reset can be
done for debug purposes or after a protocol error.
- UART needs it too, but in this case it was executed one time at
init, so hwmod was the perfect match to remove it.

> Could you elaborate on that use case? If there is a need, I'd rather =
update
> the hwmod core than letting you playing directly with the sysconfig. =
At
> least we can expose the API we did for that purpose but didn't merge =
due to
> the lack of any strong need.

I also thought of this, but then driver would need:

pm_runtime_get_sync()    // to enable the clock
pdata->device_reset()         // to set the softreset
pm_runtime_put_sync()    // to disable the clock
pm_runtime_get_sync()    // to enable again and reconfigure sysc lost
with softreset

If needed I think softreset should be handled in the device enable
path rather than a new API.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
