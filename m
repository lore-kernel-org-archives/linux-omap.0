From: Tony Lindgren <tony@atomide.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Wed, 21 May 2008 08:40:10 -0700
Message-ID: <20080521154010.GY23002@atomide.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54587 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbYEUPkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 11:40:11 -0400
Content-Disposition: inline
In-Reply-To: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

* mohammed shareef <mdshareef@gmail.com> [080520 23:43]:
> Hello,
> 
> How do i enable UART2 on omap5912_osk in the kernel?
> 
> and is there a way by which i can test if the uart2 has been recongnised?
> 
> i dont see uart module being initialized during the kernel boot-up.

You need to enable it in board-osk.c, see enabled_uarts. Then to use it
you also need the right hardware attached to it.

Tony
