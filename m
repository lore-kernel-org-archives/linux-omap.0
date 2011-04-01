From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info reordering
Date: Fri, 1 Apr 2011 09:18:30 +0200
Message-ID: <4D957C46.9020402@ti.com>
References: <1301640748-17161-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56400 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932Ab1DAHSj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Apr 2011 03:18:39 -0400
In-Reply-To: <1301640748-17161-1-git-send-email-coelho@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Coelho, Luciano" <coelho@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>

On 4/1/2011 8:52 AM, Coelho, Luciano wrote:
> The order in which the MMC cards are defined in the the 4430sdp board
> file seems to have been mistakenly reorderded as part of an unrelated
> patch.  In commit 0005ae73cfe44ee42d0be12a12cc82bf982f518e, where only
> the dev_name was supposed to be changed, the mmc order was changed as
> well.  This caused the external SD card reader not to be recognized,
> at least on Blaze.
>
> This patch reverts this change so that the external SD card is
> recognized again.
>
> Cc: Kishore Kadiyala<kishore.kadiyala@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Luciano Coelho<coelho@ti.com>
> ---
>
> I have started investigating the cause for this problem, because it
> seems to me that the value in the mmc element is what should matter,
> but it doesn't seem to be the case.  I believe there is a bug
> elsewhere, that causes the order of the array to matter, but I'm not
> very familiar with hsmmc and I don't have much time right now to delve
> into the problem, so I leave this to the omap people. ;) I can always
> help testing if necessary.

I was about to make the same comment. Why does the order matter since we 
have a .mmc field with that information? There is probably something 
broken behind that.

Regards,
Benoit
