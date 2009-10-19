From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH v2 1/2] arm: a driver for on-chip ETM and ETB
Date: Mon, 19 Oct 2009 15:57:41 +0300
Message-ID: <71a0d6ff0910190557q25cb1da2o1bcd6bdd5348c881@mail.gmail.com>
References: <1255453611-16119-1-git-send-email-virtuoso@slind.org>
	 <20091013174413.GA1134@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:30860 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZJSM5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 08:57:37 -0400
Received: by ey-out-2122.google.com with SMTP id 9so919189eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 05:57:41 -0700 (PDT)
In-Reply-To: <20091013174413.GA1134@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2009/10/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Oct 13, 2009 at 08:06:50PM +0300, Alexander Shishkin wrote:
>> Changes:
>> v2 -- major update:
>> =C2=A0 =C2=A0 =C2=A0 * fixes according to comments from Linus Wallei=
j and Anand Gadiyar
>> =C2=A0 =C2=A0 =C2=A0 * omap3 clock-related stuff moved to platform d=
evice
>
> And so what about my comments?
Ah, sorry about that. It was just that the same comments were given by
Linus, so my reply regarding those was to him.

Generally, my concern was that to make not all of the ETM versions
even have a memory-mapped registers (earlier versions use cp14
instead; I don't support those at the moment, but it might be a nice
thing to do that in future) and some of the registers which the AMBA
framework seems to rely (peripheral id and component id) on are only
available since ETMv3.2. And the most recent version mentioned in "ETM
architecture" document is 3.4.

That said, I'm personally not overly concerned about the support for
earlier versions of those macrocells and if you maintain that those
are better off implemented as AMBA drivers, I've not problem doing
that.

Regards,
--
Alex
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
