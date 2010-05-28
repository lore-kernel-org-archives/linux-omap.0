From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2] serial: Add OMAP high-speed UART driver
Date: Fri, 28 May 2010 12:41:29 +0530
Message-ID: <AANLkTikta1db8KHV2Crz1zJEagmcOI20mSnXYUq02sZ5@mail.gmail.com>
References: <58269.192.168.10.88.1274708590.squirrel@dbdmail.itg.ti.com>
	<87wruqmg85.fsf@deeprootsystems.com>
	<201005271100.41305.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:54241 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab0E1HLc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 03:11:32 -0400
In-Reply-To: <201005271100.41305.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, May 27, 2010 at 9:30 PM, Luke-Jr <luke@dashjr.org> wrote:
> On Wednesday 26 May 2010 05:48:58 pm Kevin Hilman wrote:
>> FYI... this also works on OMAP2.
>>
>> I tested it on my n810 along with UART hwmod conversion and it works
>> just fine there.
>
> Is it somehow different from the basic 8250 driver on OMAP2? I've bee=
n
> struggling to figure out why my N810's GPS isn't working when I chang=
e kernels
> (I've already made sure ttyS0 is the correct major/minor and adjusted=
 the GPIO
> calls; gpiodriver is talking to the chip, but not getting anywhere).

You need to use ttyO0 [%s/ttyS*/ttyO*]

Since uart tty interface name as been modified with this driver.

+#define OMAP_SERIAL_NAME       "ttyO"

---
Regards,
Govindraj.R


> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
