From: Kevin Hilman <khilman@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Tue, 19 Jun 2012 11:02:57 -0700
Message-ID: <87mx3zji26.fsf@ti.com>
References: <87zk8yxx9l.fsf@ti.com> <4FBD7FDC.9050307@ti.com>
	<CAP05o4KNnrKdmgJ=Ky=MS4pwEoEErH+Agkm2EwN1i1UDb-CbPQ@mail.gmail.com>
	<871um9wlzx.fsf@ti.com> <878vghut1u.fsf@ti.com>
	<4FCE46E7.60702@ti.com>
	<CAP05o4L+0E6fa1VoP_UPTJgKjXb-VqZorUfzsTB3d-KVoFrXfw@mail.gmail.com>
	<CAP05o4KuoQHhTRTCtdpiywgC1HjwzXZHhROKOgSLhoK76Z2aaQ@mail.gmail.com>
	<87fwa56gxp.fsf@ti.com>
	<CAP05o4JEEp-yXjijeeejN3j8uVBDQ35DMGqP9UKj3f7sNnO8LA@mail.gmail.com>
	<CAP05o4LYhFQpEFukyCT2fA7XHPU2L5K8=8W0fncMJk6YEUWdOQ@mail.gmail.com>
	<CAP05o4KaZ93Nt58h5ZccWeM2EazLtwOcV5rkmLvijuB5HRbJ8g@mail.gmail.com>
	<CAORVsuVpbgtS8+Jkw+Z2kA0k0SuL=kYRYcO3JRJ0D9LL34gH2Q@mail.gmail.com>
	<CAP05o4Kh+YVYgv_F-GZ=A0V+Nt=x4wCRwek81K7M=bT=PmyBGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:41945 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753211Ab2FSSC7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 14:02:59 -0400
Received: by pbbrp12 with SMTP id rp12so8378571pbb.15
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 11:02:58 -0700 (PDT)
In-Reply-To: <CAP05o4Kh+YVYgv_F-GZ=A0V+Nt=x4wCRwek81K7M=bT=PmyBGw@mail.gmail.com>
	(Keshava Munegowda's message of "Mon, 18 Jun 2012 13:39:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Ameya Palande <ameya.palande@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> On Fri, Jun 15, 2012 at 7:17 PM, Jean Pihet <jean.pihet@newoldbits.co=
m> wrote:
>> Hi Keshava,
>>
>> On Fri, Jun 15, 2012 at 2:04 PM, Munegowda, Keshava
>> <keshava_mgowda@ti.com> wrote:
>>> On Tue, Jun 12, 2012 at 6:28 PM, Munegowda, Keshava
>>> <keshava_mgowda@ti.com> wrote:
>>>> hi kevin
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 now I am using initramf=
s with kernel linux3.5.rc1,
>>>> but the retention is not working in 3430 sdp.=C2=A0 I am seeing th=
e following
>>>> error followed by a crash
>>>>
>>>>
>>>> echo mem > /sys/power/state
>>>> [=C2=A0=C2=A0 35.609252] PM: Syncing filesystems ... done.
>>>> [=C2=A0=C2=A0 35.614654] PM: Preparing system for mem sleep
>>>> [=C2=A0=C2=A0 35.658630] Freezing user space processes ... (elapse=
d 0.01 seconds)
>>>> done.
>>>> [=C2=A0=C2=A0 35.689727] Freezing remaining freezable tasks ... (e=
lapsed 0.02 seconds)
>>>> done.
>>>> [=C2=A0=C2=A0 35.697692] PM: Entering mem sleep
>>>> [=C2=A0=C2=A0 35.722442] usb usb1: usb auto-resume
>>>> [=C2=A0=C2=A0 35.726409] ehci-omap ehci-omap.0: resume root hub
>>>> [=C2=A0=C2=A0 35.775451] hub 1-0:1.0: hub_resume
>>>> [=C2=A0=C2=A0 35.779846] hub 1-0:1.0: hub_suspend
>>>> [=C2=A0=C2=A0 35.784240] usb usb1: bus suspend, wakeup 0
>>>> [=C2=A0=C2=A0 35.788665] ehci-omap ehci-omap.0: suspend root hub
>>>> [=C2=A0=C2=A0 35.805786] PM: suspend of devices complete after 99.=
304 msecs
>>>> [=C2=A0=C2=A0 35.816497] PM: late suspend of devices complete afte=
r 4.364 msecs
>>>> [=C2=A0=C2=A0 35.831573] PM: noirq suspend of devices complete aft=
er 8.331 msecs
>>>> [=C2=A0=C2=A0 35.838500] Disabling non-boot CPUs ...
>>>> [=C2=A0=C2=A0 36.312164] Powerdomain (core_pwrdm) didn't enter tar=
get state 1
>>>> [=C2=A0=C2=A0 36.318481] Could not enter target state in pm_suspen=
d
>>>> [=C2=A0=C2=A0 36.324859] Unable to handle kernel NULL pointer dere=
ference at virtual
>>>> address 00000018
>>>> [=C2=A0=C2=A0 36.333557] pgd =3D c6280000
>>>> [=C2=A0=C2=A0 36.336639] [00000018] *pgd=3D85c8f831, *pte=3D000000=
00, *ppte=3D00000000
>>>> [=C2=A0=C2=A0 36.343414] Internal error: Oops: 17 [#1] SMP ARM
>>>> [=C2=A0=C2=A0 36.348388] Modules linked in:
>>>> [=C2=A0=C2=A0 36.351623] CPU: 0=C2=A0=C2=A0=C2=A0 Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0 (3.5.0-r=
c1 #1)
>>>> [=C2=A0=C2=A0 36.357574] PC is at _od_resume_noirq+0x14/0x58
>>>> [=C2=A0=C2=A0 36.362365] LR is at dpm_run_callback+0x2c/0x74
>>
>> You need the fix from
>> https://gitorious.org/linux-omap-dss2/linux/commit/9e0ca55fa5d9ff012=
964a7c7cef8af1b814b2fdb
>>
>> Hope this helps!
>>
>> Regards,
>> Jean
>
> thanks Jean
>     I used this patch; this solved the crash issue, but suspend/resum=
e
> is still failing.

=46ailing in what way?  Did you debug any further?

It may be failing because of problems with the USB host driver, which i=
s
what I'm needing you to debug.

I'm convinced now that these USB host PM changes were not very well
tested at all as they seem to be causing a variety of different problem=
s
on my boards: faults during boot, preventing CORE idle retention,
hanging suspend/resume.

Anyways...

To get current l-o master to succesfully suspend/resume, you need 3 thi=
ngs:

1) the DSS fixes that Jean mentioned above (these are merged in
   v3.5-rc3, but not yet into l-o master)
2) disable USB host: set CONFIG_MFD_OMAP_USB_HOST=3Dn
3) for for 32k timer which is also preventing CORE retention
   http://marc.info/?l=3Dlinux-omap&m=3D134000053229888&w=3D2

With that setup on top of current l-o master, suspend/resume is working
for me on several OMAP3/4 platforms.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
