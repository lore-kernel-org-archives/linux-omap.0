From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v3] OMAP3: RX-51: complete tsc2005 controller support
Date: Wed, 14 Dec 2011 22:31:08 +0200
Message-ID: <4EE9078C.3010904@mleia.com>
References: <1323877279-10275-1-git-send-email-vladimir.zapolskiy@nokia.com> <20111214173152.GY32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:35157 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757119Ab1LNUbX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 15:31:23 -0500
In-Reply-To: <20111214173152.GY32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

On 14.12.2011 19:31, Tony Lindgren wrote:
> Hi,
>
> * Vladimir Zapolskiy<vladimir.zapolskiy@nokia.com>  [111214 07:09]:
>> This change adds initialization of TSC2005 touchscreen controller found on Nokia
>> RX-51 board.
>>
>> The change is taken from MeeGo kernel adaptation for Nokia N900, it repeats the
>> work of Aaro Koskinen and Mika Laitio, the original discussion is at
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26749.html
>
> We already have commit 3dad5356aa47097cf67027cf0a07298b4f5baef6
> queued up in linux-omap board branch. Can you please make this
> and incremental patch to that one? Looks like you got some additional
> changes like the muxing of the pins.
>

yup, initially I didn't noticed this applied commit, but if Igor and you 
encourage me to add gpio mux configurations, let it be done on top of 
Aaro's change.

-- 
With best wishes,
Vladimir
