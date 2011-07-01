From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 01 Jul 2011 07:46:37 -0700
Message-ID: <874o366otu.fsf@ti.com>
References: <87k4c3dktm.fsf@ti.com> <87vcvmaml6.fsf@ti.com>
	<201107010233.12377.rjw@sisk.pl>
	<BANLkTikLna-jbrNfD2fz_QC1BfrCHpByNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:34890 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756933Ab1GAOqm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 10:46:42 -0400
Received: by mail-iy0-f175.google.com with SMTP id 10so3516454iym.20
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 07:46:41 -0700 (PDT)
In-Reply-To: <BANLkTikLna-jbrNfD2fz_QC1BfrCHpByNA@mail.gmail.com> (Ohad
	Ben-Cohen's message of "Fri, 1 Jul 2011 08:57:40 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Ohad Ben-Cohen <ohad@wizery.com> writes:

> On Fri, Jul 1, 2011 at 3:33 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
>> In theory it is possible that a subsystem (e.g. bus type) will enabl=
e
>> runtime PM for devices without drivers and will (for example) put th=
em
>> into low power states until the drivers are loaded. =C2=A0Then, it m=
akes
>> sense for the core to prevent such transitions from racing with .pro=
be().
>>
>> I'm not sure if this happens in practice, though,
>
> Yeah, this is exactly what the SDIO subsystem is doing.

Thanks, this makes sense.

Maybe runtime_pm.txt should be updated to explain this as well.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
