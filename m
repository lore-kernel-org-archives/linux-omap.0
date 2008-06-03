From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: user space program for omap gpio
Date: Tue, 03 Jun 2008 06:19:41 -0500
Message-ID: <39d10518297acafea1e95228ee125562@felipebalbi.com>
References: <a1d91fa0806020958p21d289edrf2c63c8333af9bd4@mail.gmail.com> <20080602174456.GB4964@kedavra.cpe.vivax.com.br> <a1d91fa0806030251w27a36bb3u62cd925845817efa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33603 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYFCLTn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 07:19:43 -0400
In-Reply-To: <a1d91fa0806030251w27a36bb3u62cd925845817efa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>



On Tue, 3 Jun 2008 15:21:02 +0530, "mohammed shareef" <mdshareef@gmail.com>
wrote:
> Hi Felipe,
> 
> could you give me some useful pointers on how to use the gpio-switch
> and ioctl to read and write gpio?

gpio-switch you can check in arch/arm/mach-omap2/board-n800.c

about using ioctls for controlling the gpio, you'll have to write
a module from scratch. afaict, there's no way of controlling gpio
from userland. Besides gpiofs that a friend was writing and never
finished :-p

I'll try to reach him and ask him to send as RFC cuz it was a good
work anyway :-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

