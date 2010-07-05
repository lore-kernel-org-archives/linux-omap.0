From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] usb: musb: tusb6010: fix compile error with
 n8x0_defconfig
Date: Mon, 5 Jul 2010 13:35:05 +0300
Message-ID: <20100705103505.GF28083@nokia.com>
References: <1278321121-13474-1-git-send-email-felipe.balbi@nokia.com>
 <4C31B3B6.3020504@ru.mvista.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61630 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0GEKiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 06:38:20 -0400
Content-Disposition: inline
In-Reply-To: <4C31B3B6.3020504@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Mon, Jul 05, 2010 at 12:28:06PM +0200, ext Sergei Shtylyov wrote:
>    But will this compile on other OMAPs?

since this is a compile fix for tusb6010.c only, yes

>    I wonder what kind of compile error...

make n8x0_defconfig && make will tell you.

-- 
balbi

DefectiveByDesign.org
