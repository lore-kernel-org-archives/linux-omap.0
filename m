From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 14:45:02 +0530
Message-ID: <CAP05o4+ydLuHmVHk5toi2H8e=4Pi=2fwGa1kL1uG6BjoHu_EiQ@mail.gmail.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
	<1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
	<4F66FF47.7000800@ti.com>
	<CAP05o4+A7AZ0SmMLgCfbBHs+zhsN-c2zM8caYe8M3-OC3YmZzg@mail.gmail.com>
	<4F68453C.9040605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56338 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752633Ab2CTJPD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 05:15:03 -0400
Received: by mail-ob0-f177.google.com with SMTP id up16so2552182obb.22
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 02:15:02 -0700 (PDT)
In-Reply-To: <4F68453C.9040605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

On Tue, Mar 20, 2012 at 2:22 PM, Shubhrajyoti <shubhrajyoti@ti.com> wro=
te:
> Hi Keshava,
>
> On Tuesday 20 March 2012 12:58 PM, Munegowda, Keshava wrote:<Snip>
>>>> +}
>>>> +
>>>> +static const struct dev_pm_ops usbtllomap_dev_pm_ops =3D {
>>>> + =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D usbtll_runtime_suspe=
nd,
>>>> + =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D usbtll_runtime_resum=
e,
>>>> +};
>>>> +
>>> Also how about using runtime_pm_ops ?
>> Sorry I din't get this? what exact alternative are you suggesting he=
re?
>
> SET_RUNTIME_PM_OPS(usbtll_runtime_suspend,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usbtll=
_runtime_resume, NULL)
>
> I should have been clearer.

Thanks, I will do this , I think Felipe has already pointed out this.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
