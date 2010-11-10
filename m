From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 0/6] [v2] omap:mailbox-enhancements and fixes
Date: Wed, 10 Nov 2010 10:56:23 -0600
Message-ID: <AANLkTi=jL-aV0Xn3rcnZwaYLz9nY5QwXbGPHsdq1R2Gz@mail.gmail.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
	<4CDACB0E.3050403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44550 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125Ab0KJQ4Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 11:56:24 -0500
Received: by pva4 with SMTP id 4so165539pva.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 08:56:24 -0800 (PST)
In-Reply-To: <4CDACB0E.3050403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Benoit,

Thanks for your comments.

On Wed, Nov 10, 2010 at 10:40 AM, Cousson, Benoit <b-cousson@ti.com> wr=
ote:
> Hi Hari,
>
> On 11/10/2010 1:45 PM, Hari Kanigeri wrote:
>>
>> Thanks to Rene Sapiens and Omar Ramirez for their inputs on initial =
patch
>> set.
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37278.html
>>
>> The patch set addresses the following review comments from Rene and =
Omar.
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37626.html
>> https://patchwork.kernel.org/patch/255091/
>> https://patchwork.kernel.org/patch/255081/
>>
>> Following patches are changed because of above review comments:
>> omap:mailbox-send message in process context
>> omap:mailbox-add notification support for multiple readers
>>
>> Following patch is dropped from initial patch set
>> omap:mailbox-resolve multiple receiver problem
>>
>> The patch set is tested on omap4 SDP board.
>>
>> Fernando Guzman Lugo (1):
>> =A0 mailbox: change full flag per mailbox queue instead of global
>>
>> Hari Kanigeri (5):
>> =A0 omap:mailbox: fix rx interrupt disable in omap4
>> =A0 omap:mailbox-fix checkpatch warnings
>
> That one is weird? How can you submit a patch that fix checkpatch?

Why weird if the patch is fixing the checkpatch warnings that were
already present in the code ?
The other option is to leave the checkpatch warnings in the code :)

> In theory you should not send any patch that generate checkpatch erro=
r or
> warning.
>
>> =A0 omap:mailbox-send message in process context
>> =A0 omap:mailbox-add notification support for multiple readers
>> =A0 omap:clocks44x-add dummy clock for mailbox
>
> We are trying to enforce some consistency in the subjects name so you=
 should
> name your patches like that:

Good point, thanks for pointing about consistency. I wasn't aware
about the rule to use OMAP in caps.
I will fix it.

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
