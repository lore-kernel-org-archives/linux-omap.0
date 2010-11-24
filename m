From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Wed, 24 Nov 2010 18:11:03 +0100
Message-ID: <AANLkTi=ag81g-0iYdtAAp=tO8rUyoeE48MSnA595_daB@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<87r5edp3so.fsf@deeprootsystems.com>
	<8ef3de873d51409a38f19becb0d339cb@mail.gmail.com>
	<87pqtveq1e.fsf@deeprootsystems.com>
	<dfe358793629e4b10d1a5007fb273164@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44257 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab0KXRLF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 12:11:05 -0500
Received: by iwn38 with SMTP id 38so38622iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 09:11:04 -0800 (PST)
In-Reply-To: <dfe358793629e4b10d1a5007fb273164@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishant,

On Wed, Nov 24, 2010 at 10:22 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> (Sorry. You will see two replies from me on your email)
>> -----Original Message-----
>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>> Sent: Wednesday, November 24, 2010 11:04 AM
>> To: 'Kevin Hilman'
>> Cc: Nishanth Menon; 'linux-omap'; 'Jean Pihet'; Vishwanath Sripathy;
>> 'Tony'
>> Subject: RE: [PATCH 00/13] OMAP3: OFF mode fixes
>>
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> > owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> > Sent: Wednesday, November 24, 2010 2:06 AM
>> > To: Santosh Shilimkar
>> > Cc: Nishanth Menon; linux-omap; Jean Pihet; Vishwanath Sripathy; T=
ony
>> > Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
>> >
> [...]
>> > > And we should treat ROM code as a hardware. Secure services
>> > > don't give =A0you garrulity of saving per each secure module. To
>> > > get CPU OFF working on secure device, secure RAM must be saved.
>> > > So I still think it is CPU specific code and pretty much relevan=
t
>> > > to CPU IDLE OFF state considering ROM code.
>> > > Ofcourse this not related to GP device because we never enter Se=
cure
>> > > world again after the boot-up.
>> > > So moving this code to a separate file is fine but it still rela=
ted
>> > > to CPU.
>> >
>> > Sure, it's still *related* to the CPU, but what I am arguing is th=
at
> it
>> > should not be related to CPU *idle*.
>> >
>> > My undersanding is this (please correct me):
>> >
>> > Secure RAM context only needs to be saved/updated when something i=
n it
>> > changes changes (e.g. secure driver usage.) =A0Therefore, any
>> > driver/device usage that has a side effect of changing secure RAM
> should
>> > be responsible for updating secure RAM.
>> >
>> This assumption holds true largely but not completely. There are mor=
e
>> Secure APIs which are outside of any secure driver usage which can a=
lso
>> alter the state of secure RAM. OMAP4, we have more APIs apart from
> secure
>> RAM where the secure HW registers, firewalls, cache controllers,
> interrupt
>> controllers are managed using secure APIs. All of this is must for
> correct
>> CPU OFF functioning.
>>
>> > The approach taken in $SUBJECT series is basically: since we don't
> know
>> > who is using/changing secure RAM, we better save it (or have the
> option
>> > to) during every off-mode transition. =A0This approach is what I d=
o not
>> > like. =A0It's pushing work (and intellegence) that should be in th=
e
>> > drivers into the PM core where it does not belong.
>> >
>> The problem is because the secure RAM is not portioned per device ba=
sis
>> but managed as a whole. If we had per secure device portioning then =
the
>> respective device drivers saving it's context would have worked
> perfectly.
>> And the fact is it's not the secure device driver context, but it's =
a
>> Secure software context which runs in parallel with HLOS on HS devic=
es.
>>
>> > Rather, I want to follow the same approach we follow for every oth=
er
>> > device driver. =A0Drivers must assume they can lose context. =A0Th=
erefore
>> > it's up to them to save it.
>> >
>> > IOW, the drivers that *change* secure RAM should be responsible fo=
r
>> > ensuring that any of the changes they make are saved.
>> >
>> As I mentioned above its not just the driver context but the whole
>> secure software context. I will check with ROM team if it can be mad=
e
>> more granular for future OMAPs so that we can have the usual strateg=
y
>> of respective components taking care of there save/restore. This wil=
l
>> also save huge latency we incure while saving whole RAM on every MPU
>> OFF transition.
>>
> I had a discussion with ROM team and they conformed that the secure
> context can get changed with protected applications (PA for FW, secur=
e
> keys) as well as with secure drivers like crypto, aes etc.
>
> This can be centralized and some APIs can be provided by the secure
> middleware to know whether the context needs to be save or not.
> Secure middleware manages all the secure driver interfaces as well
> as PA's. This is the centralized place where all state knowledge is
> available. This component also can take care of doing a secure contex=
t
> save job based on needs. The only concern from them was that
> which security middleware to be used is not fixed and its
> upto customers to decide. Few of them develop this on there own.
>
> So with clarity now, I concur with your idea of moving out the secure
> context save from CPUIDLE code.
> The only problem I see is how do we support multiple security
> middleware's with a common infrastructure.

When the code is split into the pure sleep code and the secure code
parts, I would like to have the sleep code part cleaned up.
BTW I rebased my clean-up patch on top of the 13 patches you sent and
performed some testing. It is working OK AFAICT (also stands for "As
far as I can test" TM).

Can this happen before the .38 merge window?

>
> Regards
> Santosh
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
