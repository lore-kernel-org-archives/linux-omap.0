From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default pads
Date: Wed, 4 Apr 2012 11:44:48 +0530
Message-ID: <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com> <20120403181925.GH8240@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:33224 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751579Ab2DDGPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 02:15:20 -0400
Received: by obbeh20 with SMTP id eh20so732960obb.15
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 23:15:08 -0700 (PDT)
In-Reply-To: <20120403181925.GH8240@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

On Tue, Apr 3, 2012 at 11:49 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Govindraj.R <govindraj.raja@ti.com> [120321 03:06]:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> The following commit:
>> (7496ba3 =A0ARM: OMAP2+: UART: Add default mux for all uarts)
>> added default pads for all uarts. But not all boards tend to
>> use all uarts and most of unused uart pins are muxed for
>> other purpose. This commit breaks the modules which where trying
>> to use unused uart pins on their boards.
>>
>> So remove all default pads except uart1/3 as most boards
>> tend to use either uart1/3 as console port and use only tx/rx
>> lines, declare only those pads for uart1/3.
>> If any boards tend to use any other uart other uart1/3
>> the mux data should to passed from board file and init individual
>> uart port using omap_serial_init_port api.
>
> This is still wrong. We can't mux any serial pins unless specifically
> requested from the board-*.c files. So please do a fix to get back to
> v3.2 behaviour where you basically revert 7496ba3.

How to do we fix the rx pin wakeup capability?
The mux data has the info about the rx pin wakeup

Without rx pin wakeup PM will be broken.
=46ix all board files with duplicated data for uart3 or
uart1 having rx pin marked as wakeup capable?

Behavior in v3.2 was raw_write to all uarts rx_pin to enable wakeup
enable bit.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
