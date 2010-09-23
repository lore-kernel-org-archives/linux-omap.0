From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Thu, 23 Sep 2010 09:53:07 +0300
Message-ID: <20100923065307.GI2563@legolas.emea.dhcp.ti.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
 <20100923064910.GF2563@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37772 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848Ab0IWGxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 02:53:15 -0400
Content-Disposition: inline
In-Reply-To: <20100923064910.GF2563@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi again,

On Thu, Sep 23, 2010 at 01:49:10AM -0500, Balbi, Felipe wrote:
>>@@ -126,6 +128,17 @@ struct musb_hdrc_platform_data {
>>
>> 	/* Architecture specific board data	*/
>> 	void		*board_data;
>>+
>>+	/* check usb device active state*/
>>+	int		(*is_usb_active)(struct device *dev);
>
>where is it used ??

sorry, now I see, I was searching for is_musb_active (the name of the
function :-)

-- 
balbi
