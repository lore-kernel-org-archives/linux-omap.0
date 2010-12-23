From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] dspbridge: Fix atoi to support hexadecimal numbers correctly
Date: Wed, 22 Dec 2010 19:18:23 -0600
Message-ID: <AANLkTikscVzgUE3fLWD01uq6XGJw+UXxnUKcaDOg7H1A@mail.gmail.com>
References: <1292161177-5266-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<AANLkTikYnqjxpm85StwQq89b9=1_vQTt9DObeS5nwC_6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44147 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752528Ab0LWBSY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 20:18:24 -0500
Received: by mail-gw0-f48.google.com with SMTP id a20so3113244gwa.7
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 17:18:23 -0800 (PST)
In-Reply-To: <AANLkTikYnqjxpm85StwQq89b9=1_vQTt9DObeS5nwC_6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, rene.sapiens@ti.com, ernesto@ti.com, felipe.contreras@gmail.com, ionut.nicu@gmail.com

On Wed, Dec 22, 2010 at 7:00 PM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> On Sun, Dec 12, 2010 at 7:39 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> For some strange reason, the DSP base image node/object properties
>> description string stores hexadecimal numbers with a 'h' or 'H' suff=
ix
>> instead of a '0x' prefix. This causes parsing issue because the
>> dspbridge atoi() implementation relies on strict_strtoul(), which wi=
ll
>> return an error because of the trailing 'h' character.
>>
>> As the atoi() return value is never checked for an error anyway, rep=
lace
>> strict_strtoul() with simple_strtoul() to ignore the suffix.
>>
>> This fix gets rid of the following assertion failed messages that we=
re
>> printed when running the dsp-dummy test application.
>>
>> drivers/staging/tidspbridge/rmgr/nldr.c, line 1691:
>> Assertion (segid =3D=3D MEMINTERNALID || segid =3D=3D MEMEXTERNALID)=
 failed.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>> =A0drivers/staging/tidspbridge/rmgr/dbdcd.c | =A0 =A06 +-----
>> =A01 files changed, 1 insertions(+), 5 deletions(-)
>
> This patch raises a checkpatch warning:
> WARNING: consider using strict_strtoul in preference to simple_strtou=
l
>
> However on this case, simple_strtoul is preferred as explained in the=
 commit.
>
> Pushed to dspbridge.

BTW, fixing subject to "staging: tidspbridge"

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
