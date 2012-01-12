From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH 00/26] PM: Create the AVS class of drivers
Date: Thu, 12 Jan 2012 12:17:52 +0100
Message-ID: <CAORVsuUjTXSPxhRRN_eAC8oUNCeYscYu547VN52w50AdF3Zg2w@mail.gmail.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<87mx9tu3x5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52330 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab2ALLRx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 06:17:53 -0500
Received: by vcbfk14 with SMTP id fk14so1256589vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 03:17:52 -0800 (PST)
In-Reply-To: <87mx9tu3x5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: rjw@sisk.pl, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, balbi@ti.com, Jean Pihet <j-pihet@ti.com>

Hi Kevin,

On Thu, Jan 12, 2012 at 2:04 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The following patches are in RFC state; the code is still WIP and ha=
s been
>> compile tested only. Feedback on the code organization is welcome!
>
> This series looks like a good cleanup to me.
>
> Could you update this against current Linus tree which should now hav=
e
> all the OMAP stuff merged in and so we can get some broader testing h=
ere.
Ok

>
> Rafael, are you OK with this as a new driver under drivers/power/avs?
> It's only the last patch that moves the cleaned up driver under
> drivers/power/avs.
>
> Maybe we should take this in two phases. =A0For the v3.4 merge window=
, do
> the cleanup (patches 1-25), and for the following merge window, move =
it
> under drivers/power/avs and post it to a broader audience for
> discussion.
Doing it that way helps to identify the dependencies with other OMAP
specific code.

Let me refresh this patch series and re-send.

>
> Kevin

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
