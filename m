From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: [PATCH] i2c: change twl4030-usb back to subsys_initcall
Date: Fri, 3 Oct 2008 13:05:14 -0700
Message-ID: <e5e6ade50810031305x7037644crbd22fcf8d5507395@mail.gmail.com>
References: <200810030136.33838.david-b@pacbell.net>
	 <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:65266 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYJCUFP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 16:05:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so295878ywe.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 13:05:14 -0700 (PDT)
In-Reply-To: <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 3, 2008 at 2:45 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> without it, otg_get/set_transceiver won't be useful and
> twl4030-usb transceiver won't get to musb code.
>
> +subsys_init(twl4030_usb_init);

Should this be subsys_initcall?

- Nathan
