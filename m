From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: Enabling TPS65950 / TWL4030 Real-time clock functions
Date: Mon, 3 Aug 2009 15:34:14 -0400
Message-ID: <f96d234e0908031234m765dbf05s499e3537730fdc48@mail.gmail.com>
References: <4C8A2DCE-F2C2-419C-AD4A-E78BB796BCB8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f213.google.com ([209.85.217.213]:59904 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbZHCTeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 15:34:14 -0400
Received: by gxk9 with SMTP id 9so6098961gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2009 12:34:15 -0700 (PDT)
In-Reply-To: <4C8A2DCE-F2C2-419C-AD4A-E78BB796BCB8@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

On Sat, Aug 1, 2009 at 9:56 AM, Elvis Dowson<elvis.dowson@mac.com> wrot=
e:
> Hi,
> =A0 =A0 =A0 =A0 I am using a Gumstix Overo Earth (TI OMAP 3503) and t=
his has a
> TPS69590/TWL4030 module, which I understand has a real-time clock sub=
system.
>
> Is there support in the linux 2.6.29 or 2.6.31 kernel for enabling th=
e RTC
> functions? I would like to preserve the system data and time between
> reboots. I've seen a 32Khz RTC clock option in the linux kernel.
>
> Is there a separate pin for a small battery just to keep supplying po=
wer to
> the RTC module?

It looks like VBACKUP can probably be used for this.  It will power
the RTC rail if the main battery goes down.  Will this work for you?

Cliff
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
