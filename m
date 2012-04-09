From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Mon, 9 Apr 2012 16:57:23 +0530
Message-ID: <CAMrsUdLMYVwd3rupHtrNKC0rMvx1-3B=4usOh8cwTUy8DX_hVg@mail.gmail.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk>
 <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
 <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
 <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
 <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com>
 <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com> <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
 <alpine.DEB.2.00.1204051812320.10302@utopia.booyaka.com> <87iphdeyaf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47255 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755217Ab2DIL1o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Apr 2012 07:27:44 -0400
Received: by obbwd18 with SMTP id wd18so10656431obb.16
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 04:27:43 -0700 (PDT)
In-Reply-To: <87iphdeyaf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

Hi Kevin / Paul,

On Fri, Apr 6, 2012 at 7:51 PM, Kevin Hilman <khilman@ti.com> wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>
>> On Wed, 4 Apr 2012, Raja, Govindraj wrote:
>>
>>> On Wed, Apr 4, 2012 at 8:26 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>>> > On Mon, 2 Apr 2012, Raja, Govindraj wrote:
>>> >
>>> >> As of now what I can think of is to update qos reqest to prevent=
 MPU
>>> >> from transitioning in case of port activity if wakeup capability=
 for port
>>> >> is disabled.
>>> >
>>> > Haven't been following this thread closely, but this doesn't seem=
 right.
>>> > Why would changing the UART driver's ability to wake from suspend=
 via the
>>> > sysfs file prevent the driver from using hardware wakeups to wake=
 from
>>> > dynamic idle?
>>>
>>>
>>> IIUC wakeup capability is needed in suspend path or in cpu idle pat=
h.
>>>
>>> once uart wakeup capability is disabled from sysfs the Module level
>>> wakeup from PM_WKEN1 reg on omap3 and pad wakeup from pin mux data =
given
>>> will be disabled..
>>
>> As far as I know, that sysfs wakeup file is not meant to disable
>> all module-level wakeup. =A0Kevin can correct me if I'm wrong, but I=
 think
>> it's only supposed to control wakeup from suspend.
>
> In theory, sysfs control is meant for static suspend. =A0ISTR though =
that
> we were using it for idle as well so there weren't unncessary UART
> wakeups from idle on UART activity that was not serial console.

So incase of uart wakeups are disabled and uart tx/rx is requested
can we prevent MPU from low power state.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
