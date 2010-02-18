From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
Date: Thu, 18 Feb 2010 00:22:03 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9B1E@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18D9@dlee06.ent.ti.com>
 <20100217.171348.223468508.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53902 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728Ab0BRGWJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 01:22:09 -0500
In-Reply-To: <20100217.171348.223468508.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>Sent: Wednesday, February 17, 2010 9:14 AM
>To: Guzman Lugo, Fernando
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
>
>Hi Fernand,
>
>From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
>Subject: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
>Date: Sat, 13 Feb 2010 02:40:41 +0100
>
>> From 60e21e76773de379deb41ff166f9679b7078276f Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>> Date: Wed, 10 Feb 2010 17:08:20 -0600
>> Subject: [PATCH] Mailbox: change mailbox version print to pr_debug
>>
>> it is not useful printing the version every time mailbox is used
>> instead change it to pr_debug in case someone needs to see the
>> version can enable the print.
>
>I just found that, if you put the line printing version into debug
>mode, then "mbox_read_reg(MAILBOX_REVISION)" should be also done only
>in debug mode. This value wouldn't be necessary if it didn't print.
>
>Considering this printing again, this prints a message only when H/W
>initialization is done correctly, most likely only *once* at
>booting. This informs us of the result that a mailbox H/W itself is
>set up and some mailbox related modules are loaded successfully. So
>keeping this makes sense a little bit more rather than shutting this
>completely silence.

The thing was that the tests I ran does a lot of install and uninstall bridge module that why I saw a lot of this print, but yes you are right in normal operation it should be printed once. On the other hand if this is used to state loaded successfully maybe the print should be changed to more meaningfully like
"mailbox revision4.0 running or loaded"

But, let drop this patch in this moment. I will send all the patches again.

Regards,
Fernando.

