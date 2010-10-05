From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3 v5] AM35x: Add musb support
Date: Tue, 5 Oct 2010 08:41:11 +0300
Message-ID: <20101005054111.GC2643@legolas.emea.dhcp.ti.com>
References: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
 <20101001060037.GC2925@legolas.emea.dhcp.ti.com>
 <20101004172813.GV3117@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35985 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296Ab0JEFlR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 01:41:17 -0400
Content-Disposition: inline
In-Reply-To: <20101004172813.GV3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 04, 2010 at 12:28:14PM -0500, Tony Lindgren wrote:
>* Felipe Balbi <balbi@ti.com> [100930 22:52]:
>> Hi,
>>
>> On Thu, Sep 30, 2010 at 12:19:07AM -0500, Gupta, Ajay Kumar wrote:
>> >AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
>> >It has USB phy built inside the IP itself.
>> >
>> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>>
>> besides the one small question below:
>>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>
>Felipe, I'm assuming you're queuing up the omap USB platform data
>patches. So not picking up these patches.
>
>Also, please also note that the arch/arm/*omap*/ patches should
>be posted with both linux-omap and linux-arm-kernel mailing lists
>Cc'd.

I'll queue it throught Greg. Can I get your Acked-by ?

-- 
balbi
