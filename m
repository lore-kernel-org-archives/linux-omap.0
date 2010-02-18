From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
Date: Thu, 18 Feb 2010 01:22:12 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9B32@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18D9@dlee06.ent.ti.com>
	<20100217.171348.223468508.Hiroshi.DOYU@nokia.com>
	<496565EC904933469F292DDA3F1663E602CA2B9B1E@dlee06.ent.ti.com>
 <20100218.091601.228961325.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49304 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab0BRHWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 02:22:16 -0500
In-Reply-To: <20100218.091601.228961325.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Hiroshi,

>-----Original Message-----
>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>Sent: Thursday, February 18, 2010 1:16 AM
>To: Guzman Lugo, Fernando
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
>
>Hi Fernando,
>
>From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
>Subject: RE: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
>Date: Thu, 18 Feb 2010 07:22:03 +0100
>
>>
>>
>>>-----Original Message-----
>>>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>>>Sent: Wednesday, February 17, 2010 9:14 AM
>>>To: Guzman Lugo, Fernando
>>>Cc: linux-omap@vger.kernel.org
>>>Subject: Re: [PATCH 3/6] Mailbox: change mailbox version print to
>pr_debug
>>>
>>>Hi Fernand,
>>>
>>>From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
>>>Subject: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
>>>Date: Sat, 13 Feb 2010 02:40:41 +0100
>>>
>>>> From 60e21e76773de379deb41ff166f9679b7078276f Mon Sep 17 00:00:00 2001
>>>> From: Fernando Guzman Lugo <x0095840@ti.com>
>>>> Date: Wed, 10 Feb 2010 17:08:20 -0600
>>>> Subject: [PATCH] Mailbox: change mailbox version print to pr_debug
>>>>
>>>> it is not useful printing the version every time mailbox is used
>>>> instead change it to pr_debug in case someone needs to see the
>>>> version can enable the print.
>>>
>>>I just found that, if you put the line printing version into debug
>>>mode, then "mbox_read_reg(MAILBOX_REVISION)" should be also done only
>>>in debug mode. This value wouldn't be necessary if it didn't print.
>>>
>>>Considering this printing again, this prints a message only when H/W
>>>initialization is done correctly, most likely only *once* at
>>>booting. This informs us of the result that a mailbox H/W itself is
>>>set up and some mailbox related modules are loaded successfully. So
>>>keeping this makes sense a little bit more rather than shutting this
>>>completely silence.
>>
>> The thing was that the tests I ran does a lot of install and
>> uninstall bridge module that why I saw a lot of this print, but yes
>> you are right in normal operation it should be printed once. On the
>> other hand if this is used to state loaded successfully maybe the
>> print should be changed to more meaningfully like
>> "mailbox revision4.0 running or loaded"
>>
>> But, let drop this patch in this moment. I will send all the patches
>> again.
>
>Agreed.
>
>When you resend them again, then please include mine [5/6] attached
>too. It's much easier.
>
>I ack'ed all of them.

Oops, I have already send them, but let me send them again including your patch and description and your ack's

Regards,
Fernando.
