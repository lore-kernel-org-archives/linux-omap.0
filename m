From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 19:44:28 -0600
Message-ID: <CAB-zwWg0FkNEHHVS=Hy-US9=xkueg_skUX7VCLS=QVN3ubTsTw@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
	<CAMP44s16cSBw23Py7qUW4Oj60gXKuvmtx-c=urisxecMQEE6Dw@mail.gmail.com>
	<CAB-zwWiH020HfovGF8CA-v9t8Pjc3kLbsXezN6ToLdyC4muHqA@mail.gmail.com>
	<20111209000733.GA9504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51846 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752989Ab1LIBoa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Dec 2011 20:44:30 -0500
Received: by mail-ww0-f47.google.com with SMTP id dr10so3199639wgb.16
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 17:44:29 -0800 (PST)
In-Reply-To: <20111209000733.GA9504@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Thu, Dec 8, 2011 at 6:07 PM, Greg KH <greg@kroah.com> wrote:
>> > Definitely 3.2-fix material IMO :)
>>
>> I believe it was pushed to staging-next... I'm rooting so it can be
>> pushed to staging-linus :)
>
> As it wasn't originally stated that this was a problem that needed to=
 be
> fixed for 3.2, can it wait for 3.3-rc1? =A0Especially given that ther=
e is
> still discussion about this?

No discussion from me either.

The original intention was to include this patch for 3.2 because of
the recent changes in dm timer framework, I apologize if "This was
first seen on 3.2-rc1." is too ambiguous. I hope this can make it for
3.2 though.

Thanks,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
