From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC PATCH v3] Consolidate SRAM support
Date: Fri, 13 May 2011 11:25:30 +0200
Message-ID: <BANLkTi=0-dFd2XG7U7=eAy2XS_sakqmekA@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110512174546.GB8633@n2100.arm.linux.org.uk>
	<BANLkTimmCuxUUY46B+aY5C0KxnY4_Dvucg@mail.gmail.com>
	<20110513091123.GA20941@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43714 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758032Ab1EMJZa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 05:25:30 -0400
Received: by qwk3 with SMTP id 3so1189354qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 02:25:30 -0700 (PDT)
In-Reply-To: <20110513091123.GA20941@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, May 13, 2011 at 11:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 13, 2011 at 09:30:14AM +0200, Jean Pihet wrote:
>> On Thu, May 12, 2011 at 7:45 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > =A0 =A0This version fixes the davinci pm free, and adds updates fo=
r the
>> > =A0 =A0davinci pcm driver. =A0As I don't know what's happening wit=
h Jean's
>> > =A0 =A0patch tweaking the genpool allocator, I've kept my version.
>>
>> Sorry I do not get the question. The latest changes I submitted have
>> been merged in mainline as 'ARM: 6649/1: omap: use fncpy to copy the
>> PM code functions to SRAM' [1] . Thanks for that!
>> This change is only about the simple linear SRAM allocator, not the
>> genpool allocator.
>
> The wrong Jean! =A0I meant Jean-Christophe PLAGNIOL-VILLARD.
Ok, sorry about that!

Regards,
Jean

>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
