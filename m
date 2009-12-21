From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [rfc/rft/patch-v2.6.32-omap1+ 1/2] arm: omap: clock: add
 omap_udc to clkdev
Date: Mon, 21 Dec 2009 09:05:29 +0200
Message-ID: <20091221070529.GA30969@nokia.com>
References: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com>
 <1261000355-2174-2-git-send-email-felipe.balbi@nokia.com>
 <alpine.DEB.2.00.0912171904330.12561@utopia.booyaka.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40766 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbZLUHGk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 02:06:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912171904330.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <kjh@hilman.org>

On Fri, Dec 18, 2009 at 03:05:09AM +0100, ext Paul Walmsley wrote:
>Hi Felipe,
>
>On Wed, 16 Dec 2009, Felipe Balbi wrote:
>
>> then we can later remove all of those cpu conditionals
>> on drivers/usb/gadget/omap_udc.c
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>> ---
>>
>> Paul, do you think the following is correct ? Judging
>> by omap_udc.c those are the clocks used by that driver
>> but I don't have boards to try out.
>
>I guess these can also be used by ohci-omap.c ?

in that case do we add two CLK() entries ?

-- 
balbi
