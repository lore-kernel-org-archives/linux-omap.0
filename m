From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: [PATCH] usb: add back otg_get_transceiver
Date: Fri, 3 Oct 2008 13:04:27 -0700
Message-ID: <e5e6ade50810031304x6aa4a6dfj5b92e730221d85f1@mail.gmail.com>
References: <1223043350-17588-1-git-send-email-felipe.balbi@nokia.com>
	 <20081003143132.GG6251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:4975 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbYJCUE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 16:04:28 -0400
Received: by yw-out-2324.google.com with SMTP id 9so295784ywe.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 13:04:27 -0700 (PDT)
In-Reply-To: <20081003143132.GG6251@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Oct 3, 2008 at 7:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [081003 17:18]:
>> make twl4030_usb transceiver reach musb.
>
> Pushed until you have something in mainline.

Now that this is in linux-omap git, my BeagleBoard no longer boots due
to a null dereference in musb_platform_init (*x).

Applying "i2c: change twl4030-usb back to subsys_initcall" from
earlier today allows the kernel to boot.

- Nathan
