From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [rfc/rft/patch 3/9] arm: omap: zoom: use vmmc1 regulator supply
Date: Tue, 1 Dec 2009 15:10:40 +0200
Message-ID: <20091201131039.GA12437@nokia.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
 <1259672635-12306-4-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ABC1E20@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58596 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbZLANLc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:11:32 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ABC1E20@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

Hi,

On Tue, Dec 01, 2009 at 02:08:26PM +0100, ext Gadiyar, Anand wrote:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
>> Sent: Tuesday, December 01, 2009 6:34 PM
>> To: Tony Lindgren
>> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; Kevin
>> Hilman; Kalle Valo; Jean Pihet; Pandita, Vikram; Paul
>> Walmsley; Hiroshi DOYU; David Brownell; Felipe Balbi
>> Subject: [rfc/rft/patch 3/9] arm: omap: zoom: use vmmc1
>> regulator supply
>>
>> the structure was there but it was used by the
>> twl4030 pdata. Just adding the missing field.
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>
>I had already posted this patch.

sorry for that... let's drop this one then

-- 
balbi
