From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/6] [v2] omap:mailbox-enhancements and fixes
Date: Wed, 10 Nov 2010 17:40:46 +0100
Message-ID: <4CDACB0E.3050403@ti.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55196 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757010Ab0KJQkX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 11:40:23 -0500
In-Reply-To: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Hari,

On 11/10/2010 1:45 PM, Hari Kanigeri wrote:
> Thanks to Rene Sapiens and Omar Ramirez for their inputs on initial patch
> set.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37278.html
>
> The patch set addresses the following review comments from Rene and Omar.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37626.html
> https://patchwork.kernel.org/patch/255091/
> https://patchwork.kernel.org/patch/255081/
>
> Following patches are changed because of above review comments:
> omap:mailbox-send message in process context
> omap:mailbox-add notification support for multiple readers
>
> Following patch is dropped from initial patch set
> omap:mailbox-resolve multiple receiver problem
>
> The patch set is tested on omap4 SDP board.
>
> Fernando Guzman Lugo (1):
>    mailbox: change full flag per mailbox queue instead of global
>
> Hari Kanigeri (5):
>    omap:mailbox: fix rx interrupt disable in omap4
>    omap:mailbox-fix checkpatch warnings

That one is weird? How can you submit a patch that fix checkpatch?
In theory you should not send any patch that generate checkpatch error 
or warning.

>    omap:mailbox-send message in process context
>    omap:mailbox-add notification support for multiple readers
>    omap:clocks44x-add dummy clock for mailbox

We are trying to enforce some consistency in the subjects name so you 
should name your patches like that:

     OMAP: mailbox: fix rx interrupt disable in omap4
     OMAP: mailbox: fix checkpatch warnings
     OMAP: mailbox: send message in process context
     OMAP: mailbox: add notification support for multiple readers
     OMAP4: clocks: add dummy clock for mailbox


Regards,
Benoit
