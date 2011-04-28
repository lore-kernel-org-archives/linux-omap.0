From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework with
 device-specific OPPs
Date: Thu, 28 Apr 2011 16:16:58 +0900
Message-ID: <BANLkTim8=L-5C8ePwoWWB5Po0dQ6ud3AvQ@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTinP0_qpF3sp8CzDy42i24wqqo7ohw@mail.gmail.com>
	<BANLkTin-OMyrz=McN6X4TAZrvv3ehVBGew@mail.gmail.com>
	<BANLkTikVHs1n8fXEAZh6Q4io39eD9PG14w@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56305 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab1D1HRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 03:17:00 -0400
Received: by bwz15 with SMTP id 15so2053305bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 00:16:59 -0700 (PDT)
In-Reply-To: <BANLkTikVHs1n8fXEAZh6Q4io39eD9PG14w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Apr 28, 2011 at 3:43 PM, Colin Cross <ccross@google.com> wrote:
> I understand the need for some sort of governor that can use device
> state to determine the necessary clock frequencies. =C2=A0Where I dis=
agree
> is the connection to voltages. =C2=A0The governor should ONLY determi=
ne the
> frequencies desired, and the voltage required to meet those
> frequencies should be determined by the clock framework, based only o=
n
> the clock and the frequency.

Yes, as long as AVS(Adaptive Voltage Scaling) is not involved, devfreq
does not need to care about voltages and let device driver (such as
the target callback or its callee) take care of voltages. Besides, my
impression on AVS is that AVS wouldn't be depending on software DVFS
scheme, at least with some AVS test on S5PC110. So, I'd say that it's
safe to let devfreq framework handle frequency only and let target
callback handle anything else except for choosing representative clock
frequency.

However, if we are going to detach devfreq from OPP, we only need to
provide frequency list at init and { an interface to control max/min
freq or an interface to lookup max/min freq of corresponding
representative clock. }

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>

ps. In our AVS test, the device drivers had nothing to do with voltage
scaling except for initializing devices. The H/W did everything about
voltage scaling dynamically.

Thanks,

MyungJoo.
--=20
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
