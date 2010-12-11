From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: Re: [PATCH 5/5 v5] usb: musb: Using runtime pm APIs for musb.
Date: Sat, 11 Dec 2010 08:28:03 +0530
Message-ID: <AANLkTim6ZAiL+A3X_6HQEdDd5nYh_79Q7Jteq9v+6jP9@mail.gmail.com>
References: <1291991739-21705-1-git-send-email-hemahk@ti.com>
	<1291991739-21705-6-git-send-email-hemahk@ti.com>
	<20101210143811.GS6027@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33271 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243Ab0LKC6F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 21:58:05 -0500
In-Reply-To: <20101210143811.GS6027@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Dec 10, 2010 at 8:08 PM, Felipe Balbi <balbi@ti.com> wrote:
> hi,
>
> On Fri, Dec 10, 2010 at 08:05:39PM +0530, Hema HK wrote:
>>
>> Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_syn=
c()
>> for enabling/disabling the clocks, sysconfig settings.
>>
>> enable clock, configure no-idle/standby when active and configure fo=
rce
>> idle/standby
>> and disable clock when idled. This is taken care by the runtime fram=
ework
>> when
>> driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.
>> Need to configure MUSB into force standby and force idle mode when u=
sb not
>> used
>>
>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> ---
>>
>> drivers/usb/musb/musb_core.h | =A0 =A02 -
>> drivers/usb/musb/omap2430.c =A0| =A0 80
>> +++++++++++--------------------------------
>> 2 files changed, 23 insertions(+), 59 deletions(-)
>
> Now I see you removed the runtime_resume and runtime_suspend calls fr=
om
> musb_core. Won't we loose context in that case ?
>
We need context save/restore  when .suspend/.resume are called. That
is done anyway in the musb_suspend/
musb_resume_noirq APIs.  Moreover we are calling runtime pm with
musb_omap2430 dev pointer, so
musb runtime_suspend/resume call backs will not be called.

Regards,
Hema
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
