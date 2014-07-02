From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
Date: Wed, 2 Jul 2014 14:08:02 +1000
Message-ID: <CAPM=9tzQR446Xc2xnrSOGa+VetO44KskMFrkPqbatwsmv1dHXQ@mail.gmail.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
	<1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
	<53ADEB73.8090301@ti.com>
	<20140701233958.GA31549@fox>
	<53B36EF1.8060200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:65081 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaGBEIF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 00:08:05 -0400
Received: by mail-lb0-f178.google.com with SMTP id 10so7555659lbg.37
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 21:08:02 -0700 (PDT)
In-Reply-To: <53B36EF1.8060200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Darren Etheridge <detheridge@ti.com>
Cc: =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Mack <zonque@gmail.com>, =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2 July 2014 12:31, Darren Etheridge <detheridge@ti.com> wrote:
> On 07/01/2014 06:39 PM, Guido Mart=C3=ADnez wrote:
>>
>> On Fri, Jun 27, 2014 at 05:08:51PM -0500, Darren Etheridge wrote:
>>>
>>> [snip]
>>>
>>> Otherwise I think this is a good and useful patch series.
>>
>> It that a Tested-by tag? :)
>
>
> Sure - I would prefer that the WARN_ON was silenced when the tilcdc m=
odule
> is removed, but the series adds improvements over what is there now. =
 I have
> tested it across a few variants of AM335x boards and attached display
> hardware in both module form and built-in to the kernel, therefore:
>
> Tested-by: Darren Etheridge <detheridge@ti.com>

Has someone gathered that tags and put these in a git tree by any chanc=
e?

Dave.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
