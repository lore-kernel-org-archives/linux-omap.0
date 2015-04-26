From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Date: Sun, 26 Apr 2015 12:46:37 -0700
Message-ID: <553D409D.2040808@roeck-us.net>
References: <20150424190207.GU19431@pengutronix.de> <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de> <20150425021024.GA14963@saruman.tx.rr.com> <553D0450.6050403@roeck-us.net> <20150426191216.GZ19431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36310 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbDZTqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2015 15:46:49 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmSVt-003AJy-4p
	for linux-omap@vger.kernel.org; Sun, 26 Apr 2015 19:46:49 +0000
In-Reply-To: <20150426191216.GZ19431@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: balbi@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Wim Van Sebroeck <wim@iguana.be>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-watchdog@vger.kernel.org, kernel@pengutronix.de

On 04/26/2015 12:12 PM, Uwe Kleine-K=F6nig wrote:
> On Sun, Apr 26, 2015 at 08:29:20AM -0700, Guenter Roeck wrote:
>> On 04/24/2015 07:10 PM, Felipe Balbi wrote:
>>> On Fri, Apr 24, 2015 at 10:20:50PM +0200, Uwe Kleine-K=F6nig wrote:
>>>> ti,hwmods doesn't belong into the compatible section but is a prop=
erty
>>>> on it's own. Also reformat the section of required properties to m=
atch the
>>>> usual style of dt binding documents.
>>>>
>>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>>>
>>> looks great to me, thanks
>>>
>>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>>
>>
>> Reviewed-by: and Acked-by: are mutually exclusive.
> Really? Acked means you like it and Reviewed by means you looked deep=
er
> into it. Maybe reviewing without liking isn't likely, *shrug*.
>

SubmittingPatches says about Acked-by:

" ... to signify and record their approval ... has at least reviewed th=
e patch
and has indicated acceptance ...".

and about Reviewed-by:

" ... indicates that the patch has been reviewed and found acceptable .=
=2E."

Maybe I should have used the term "redundant". *shrugtoo*.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
