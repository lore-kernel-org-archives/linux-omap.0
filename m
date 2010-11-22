From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH] omap4: 4430sdp: enable the ehci port on 4430SDP
Date: Mon, 22 Nov 2010 17:24:08 +0530
Message-ID: <4CEA59E0.8080705@ti.com>
References: <1290364999-4783-1-git-send-email-gadiyar@ti.com> <20101122101737.GN2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53912 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754912Ab0KVLyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 06:54:15 -0500
Received: by gwaa18 with SMTP id a18so2182176gwa.37
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:54:14 -0800 (PST)
In-Reply-To: <20101122101737.GN2446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Tony Lindgren <tony@atomide.com>

On 11/22/2010 3:47 PM, Felipe Balbi wrote:
> On Mon, Nov 22, 2010 at 12:13:19AM +0530, Anand Gadiyar wrote:
>> From: Keshava Munegowda <keshava_mgowda@ti.com>
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
> 
> Tony, if you give me your Ack I can take this with Greg since it depends
> on the series I'm checking now.
> 

This one can go through Tony - I deliberately left it out of the EHCI series.

The dependency is needed for the EHCI port to actually be usable, however we
can register the device in the board file independently of the driver.

I forgot to update the patch description - I'll wait some more for any
more comments and then repost with a proper description.

- Anand


