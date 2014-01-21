From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 0/6] N900 DTS additions for 3.14
Date: Tue, 21 Jan 2014 12:59:42 +0100
Message-ID: <52DE612E.2080205@baylibre.com>
References: <1389475023-11616-1-git-send-email-sre@debian.org> <20140120155950.GB17118@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:52971 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbaAUL7r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 06:59:47 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so7830601wes.6
        for <linux-omap@vger.kernel.org>; Tue, 21 Jan 2014 03:59:44 -0800 (PST)
In-Reply-To: <20140120155950.GB17118@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Sebastian,

On 20/01/2014 16:59, Sebastian Reichel wrote:
> On Sat, Jan 11, 2014 at 10:16:57PM +0100, Sebastian Reichel wrote:
>> Here are a couple of additions for the Nokia N900 Device Tree
>> Source file. All related drivers changes are queued for 3.14
>> (except for the tpa6130a2, which got merged into 3.13).
>>
>> I may have some more additions if the driver changes for the
>> accelerometer, the touchscreen or the wireless lan chip will be
>> queued up.
>
> ping?
>
> Also it seems, that for_3.14/dts branch on bcousson/linux-omap-dt.git
> merged some branches, which Tony no longer intends to be merged for
> 3.14.

Yeah, I will have to sync with Tony to understand what will be in 3.14-=
rc1.

Do you have strong dep with the series Tony has done?

Regards,
Benoit

--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
