From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/8] : Hwmod api changes
Date: Mon, 09 Aug 2010 17:05:55 +0200
Message-ID: <4C601953.7070309@ti.com>
References: <1281115688-1429-1-git-send-email-hemahk@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401D2AC@dbde02.ent.ti.com> <alpine.DEB.2.00.1008090156250.8958@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401D438@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401D438-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/9/2010 11:37 AM, Nayak, Rajendra wrote:
>
>
>> From: Paul Walmsley [mailto:paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org]
>> Sent: Monday, August 09, 2010 1:51 PM
>>
>> (cc Beno=EEt)
>>
>> On Mon, 9 Aug 2010, Nayak, Rajendra wrote:
>>
>>> Does it make sense for the framework itself to enable wakeup
>>> for all devices when the slave port is programmed to be in
>>> Smartidle
>>
>> It seems to me that they are separate mechanisms?  If a module is
>> programmed for slave smart-idle, then the module prevents the
>> PRCM from
>> shutting off the module clock(s) until the module is not
>> busy.  This seems
>> distinct from ENAWAKEUP, which I thought simply controlled
>> whether the
>> module would assert the SWakeup signal to the PRCM when an
>> external wakeup
>> condition occurred for that module.  Is that an accurate summary?
>
> hmm.. the reason I thought the two were related was because the need =
to
> assert a SWakeup will arise only when the module is programmed in sma=
rt-idle.
> If the module is either in no-idle (in which case no idle-ack is asse=
rted
> by the module) or force-idle (when the module is forced to idle and
> expected to stay idle) there might not be a need for the module to be
> capable of asserting a SWakeup.

In fact, the SWakeup is asserted as soon as the module is in idle=20
(idle_ack =3D 1) and cannot use the OCP interface to communicate a IRQ_=
REQ=20
or DMA_REQ.
But the wakeup capability is disabled by setting the SidleMode to=20
=46orce-Idle, regardless of the value of Wakeup enable.
Bottom-line is that the SWakeup can be asserted only if the module is i=
n=20
smart-idle.

> The reason I proposed ENAWAKEUP to be always enabled with smart-idle =
was
> with as understanding that we may never have a case wherein the modul=
e
> is programmed in smart-idle but not expected to assert SWakeup (if it
> supports one). I will check up on this if there ever could be such a
> case.

This is something that can make sense on OMAP4, because the wakeup=20
status is de-asserted automatically as soon as the interrupt status is=20
cleared.
On previous platform, as Paul said, we will have to handle that manuall=
y=20
somewhere, but preferably not in driver directly.
It will not be that straightforward.

>>
>>> instead of exposing 2 more omap device level api;s to the drivers?
>>
>> Something like this probably needs to be exposed to core code
>> that would
>> also set/clear PM_WKEN_* for the appropriate processor
>> module.  Right now
>> we just set a bunch of these bits directly in pmXXXX.c, and
>> that needs to
>> change.
>>
>> The other issue is that I suspct the module needs to be
>> enabled in order
>> for SYSCONFIG writes to succeed; right now the underlying
>> hwmod code does
>> not appear to enforce this :-(

At least we have a comment saying that we should do it :-)
We probably just need to ensure that a module is enabled before=20
accessing the sysconfig.

Regards,
Benoit

>>
>> But I don't see why drivers would need to call these
>> functions directly.
>> Hema, was that your intention?  If so, you could you please
>> explain the
>> use case?
>>
>>> I have a patch for this and can post it for review in case you
>>> feel it makes sense.
>>
>>
>> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
