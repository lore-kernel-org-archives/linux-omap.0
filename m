From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] usb: musb: tusb6010: fix compile error with n8x0_defconfig
Date: Mon, 05 Jul 2010 14:28:06 +0400
Message-ID: <4C31B3B6.3020504@ru.mvista.com>
References: <1278321121-13474-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63720 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0GEK3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 06:29:13 -0400
In-Reply-To: <1278321121-13474-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hello.

felipe.balbi@nokia.com wrote:

> From: Felipe Balbi <felipe.balbi@nokia.com>

> Drop the unnecessary empty stubs in tusb6010.c and avoid

    But will this compile on other OMAPs?

> a compile error when building kernel for n8x0.

    I wonder what kind of compile error...

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

WBR, Sergei
