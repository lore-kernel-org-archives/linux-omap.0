From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: [PATCH] MUSB: BULK request on different available endpoints
Date: Mon, 6 Oct 2008 23:06:29 -0700
Message-ID: <e5e6ade50810062306g7734b253j1e08f985b2d0ff68@mail.gmail.com>
References: <1223358144-19712-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:49583 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYJGGGa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 02:06:30 -0400
Received: by qw-out-2122.google.com with SMTP id 3so707511qwe.37
        for <linux-omap@vger.kernel.org>; Mon, 06 Oct 2008 23:06:29 -0700 (PDT)
In-Reply-To: <1223358144-19712-1-git-send-email-ajay.gupta@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, david-b@pacbell.net, me@felipebalbi.com

On Mon, Oct 6, 2008 at 10:42 PM, Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> Fixes co-working issue of usb serial device with usb/net devices while
> oter endpoints are free and can be used.This patch implements the policy
> that if endpoint resources are available then different BULK request goes
> to different endpoint otherwise they are multiplexed to one reserved
> endpoint as currently done.

Tested with current linux-omap git (plus other MUSB patches from
Ajay).  It works great for me.  No problems running serial, wifi, and
cameras at once off MUSB host.

Thank you!
- Nathan
