From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] drivers/gpio: using common order: let 'static const'
 instead of 'const static'
Date: Wed, 6 Feb 2013 16:11:19 +0530
Message-ID: <5112334F.1020508@ti.com>
References: <51122147.6080708@asianux.com> <5112241B.8050207@ti.com> <511232B1.7090206@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54297 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754908Ab3BFKkL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 05:40:11 -0500
In-Reply-To: <511232B1.7090206@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org

On Wednesday 06 February 2013 04:08 PM, Chen Gang wrote:
> =E4=BA=8E 2013=E5=B9=B402=E6=9C=8806=E6=97=A5 17:36, Santosh Shilimka=
r =E5=86=99=E9=81=93:
>> On Wednesday 06 February 2013 02:54 PM, Chen Gang wrote:
>>>>
>>>>     'const static ' is not a common order, better to use 'const st=
atic' instead.
>> You mean  " use static const  instead ", right ?
>>
>
>    oh, yes.  it is my miswritten.
>
>    if necessary to send patch v2, please tell me.
>
Please do send updated version.

Regards,
Santosh

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
