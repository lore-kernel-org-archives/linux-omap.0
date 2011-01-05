From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v3 06/17] OMAP2,3 DSS2 Move DSS driver register from board
 file to devices.c
Date: Wed, 5 Jan 2011 16:25:46 +0530
Message-ID: <AANLkTik4PW=XCk3s7Y7AdmRBA+cezts3uD5AkLYkOkuR@mail.gmail.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
 <1294059069-26737-7-git-send-email-svadivu@ti.com> <1294224676.14254.40.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:60582 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630Ab1AEK4H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 05:56:07 -0500
Received: by qwg5 with SMTP id 5so14573838qwg.34
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 02:56:06 -0800 (PST)
In-Reply-To: <1294224676.14254.40.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Guruswamy Senthilvadivu <svadivu@ti.com>, paul@pwsan.com, khilman@deeprootsystems.com, a0919096@ti.com, linux-omap@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Tomi,

On Wed, Jan 5, 2011 at 4:21 PM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Hi,
>
> On Mon, 2011-01-03 at 18:20 +0530, ext Guruswamy Senthilvadivu wrote:
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> omap_display_init function is introduced in devices.c to do the DSS =
driver
>> registration. =A0So replace platform_device_register or platform_add=
_devices of
>> DSS with omap_display_init().
>
> This and two previous patches are missing a color in the subject.
>
> I'm also ok with Kevin's suggestion to put display code in separate
> file. There's other stuff to add there also at some point, like chang=
ing
> pinmuxing.
>
> Also, I think it would be cleaner to first add the new code to device=
s.c
> (or display.c) and display.h in one patch, then in another patch chan=
ge
> the board files to use this new display init.
Since Senthil is going to be out for some time, I am in the process of
updating this patch-set based on Kevin's, Tony's and your comment. I
should be able to give you the updated set pretty soon.

Best regards,
~Sumit.
>
> =A0Tomi
>
>
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
