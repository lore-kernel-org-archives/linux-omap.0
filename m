From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Mon, 18 Jun 2012 13:39:08 +0530
Message-ID: <CAP05o4Kh+YVYgv_F-GZ=A0V+Nt=x4wCRwek81K7M=bT=PmyBGw@mail.gmail.com>
References: <87zk8yxx9l.fsf@ti.com>
	<4FBD7FDC.9050307@ti.com>
	<CAP05o4KNnrKdmgJ=Ky=MS4pwEoEErH+Agkm2EwN1i1UDb-CbPQ@mail.gmail.com>
	<871um9wlzx.fsf@ti.com>
	<878vghut1u.fsf@ti.com>
	<4FCE46E7.60702@ti.com>
	<CAP05o4L+0E6fa1VoP_UPTJgKjXb-VqZorUfzsTB3d-KVoFrXfw@mail.gmail.com>
	<CAP05o4KuoQHhTRTCtdpiywgC1HjwzXZHhROKOgSLhoK76Z2aaQ@mail.gmail.com>
	<87fwa56gxp.fsf@ti.com>
	<CAP05o4JEEp-yXjijeeejN3j8uVBDQ35DMGqP9UKj3f7sNnO8LA@mail.gmail.com>
	<CAP05o4LYhFQpEFukyCT2fA7XHPU2L5K8=8W0fncMJk6YEUWdOQ@mail.gmail.com>
	<CAP05o4KaZ93Nt58h5ZccWeM2EazLtwOcV5rkmLvijuB5HRbJ8g@mail.gmail.com>
	<CAORVsuVpbgtS8+Jkw+Z2kA0k0SuL=kYRYcO3JRJ0D9LL34gH2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41090 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223Ab2FRIJL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 04:09:11 -0400
Received: by lbbgk8 with SMTP id gk8so4587290lbb.12
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 01:09:08 -0700 (PDT)
In-Reply-To: <CAORVsuVpbgtS8+Jkw+Z2kA0k0SuL=kYRYcO3JRJ0D9LL34gH2Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Ameya Palande <ameya.palande@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

On Fri, Jun 15, 2012 at 7:17 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Hi Keshava,
>
> On Fri, Jun 15, 2012 at 2:04 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
>> On Tue, Jun 12, 2012 at 6:28 PM, Munegowda, Keshava
>> <keshava_mgowda@ti.com> wrote:
>>> hi kevin
>>> =A0=A0=A0=A0=A0=A0=A0 now I am using initramfs with kernel linux3.5=
=2Erc1,
>>> but the retention is not working in 3430 sdp.=A0 I am seeing the fo=
llowing
>>> error followed by a crash
>>>
>>>
>>> echo mem > /sys/power/state
>>> [=A0=A0 35.609252] PM: Syncing filesystems ... done.
>>> [=A0=A0 35.614654] PM: Preparing system for mem sleep
>>> [=A0=A0 35.658630] Freezing user space processes ... (elapsed 0.01 =
seconds)
>>> done.
>>> [=A0=A0 35.689727] Freezing remaining freezable tasks ... (elapsed =
0.02 seconds)
>>> done.
>>> [=A0=A0 35.697692] PM: Entering mem sleep
>>> [=A0=A0 35.722442] usb usb1: usb auto-resume
>>> [=A0=A0 35.726409] ehci-omap ehci-omap.0: resume root hub
>>> [=A0=A0 35.775451] hub 1-0:1.0: hub_resume
>>> [=A0=A0 35.779846] hub 1-0:1.0: hub_suspend
>>> [=A0=A0 35.784240] usb usb1: bus suspend, wakeup 0
>>> [=A0=A0 35.788665] ehci-omap ehci-omap.0: suspend root hub
>>> [=A0=A0 35.805786] PM: suspend of devices complete after 99.304 mse=
cs
>>> [=A0=A0 35.816497] PM: late suspend of devices complete after 4.364=
 msecs
>>> [=A0=A0 35.831573] PM: noirq suspend of devices complete after 8.33=
1 msecs
>>> [=A0=A0 35.838500] Disabling non-boot CPUs ...
>>> [=A0=A0 36.312164] Powerdomain (core_pwrdm) didn't enter target sta=
te 1
>>> [=A0=A0 36.318481] Could not enter target state in pm_suspend
>>> [=A0=A0 36.324859] Unable to handle kernel NULL pointer dereference=
 at virtual
>>> address 00000018
>>> [=A0=A0 36.333557] pgd =3D c6280000
>>> [=A0=A0 36.336639] [00000018] *pgd=3D85c8f831, *pte=3D00000000, *pp=
te=3D00000000
>>> [=A0=A0 36.343414] Internal error: Oops: 17 [#1] SMP ARM
>>> [=A0=A0 36.348388] Modules linked in:
>>> [=A0=A0 36.351623] CPU: 0=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0=A0=A0 =
W=A0=A0=A0=A0 (3.5.0-rc1 #1)
>>> [=A0=A0 36.357574] PC is at _od_resume_noirq+0x14/0x58
>>> [=A0=A0 36.362365] LR is at dpm_run_callback+0x2c/0x74
>
> You need the fix from
> https://gitorious.org/linux-omap-dss2/linux/commit/9e0ca55fa5d9ff0129=
64a7c7cef8af1b814b2fdb
>
> Hope this helps!
>
> Regards,
> Jean

thanks Jean
    I used this patch; this solved the crash issue, but suspend/resume
is still failing.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
