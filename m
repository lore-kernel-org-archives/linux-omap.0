From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: user space program for omap gpio
Date: Mon, 2 Jun 2008 20:44:57 +0300
Message-ID: <20080602174456.GB4964@kedavra.cpe.vivax.com.br>
References: <a1d91fa0806020958p21d289edrf2c63c8333af9bd4@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53297 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYFBRoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 13:44:38 -0400
Content-Disposition: inline
In-Reply-To: <a1d91fa0806020958p21d289edrf2c63c8333af9bd4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>

On Mon, Jun 02, 2008 at 10:28:02PM +0530, mohammed shareef wrote:
> Hi,
> 
> i want to access the omap5912 GPIO pins from user space... like
> reading the pin or writing to it from a user space program. is it
> possible?

Maybe you can use gpio-switch for reading. But for writing, then you
would have to write your own module with, maybe, ioctl for writing to
gpios.

I don't know of any already implemented way for completely handling
gpios via userland.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
