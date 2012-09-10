From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [balbi-usb:gadget 58/62] drivers/usb/gadget/ether.c:113:1: error:
 expected ')' before '.' token
Date: Mon, 10 Sep 2012 16:06:48 +0200
Message-ID: <504DF3F8.6080208@linutronix.de>
References: <20120910135441.GA12990@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50194 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757174Ab2IJOGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 10:06:51 -0400
In-Reply-To: <20120910135441.GA12990@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: kernel-janitors@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On 09/10/2012 03:54 PM, Fengguang Wu wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git g=
adget
> head:   7a7322b0a5d984025dd4faea9098b8fef07f8d8f
> commit: 721e2e91945bc2520d57d795dfe1b502ecec567c [58/62] usb: gadget:=
 libcomposite: move composite.c into libcomposite
> config: x86_64-randconfig-s284 (attached as .config)
>
> All related error/warning messages:
>
> In file included from drivers/usb/gadget/ether.c:110:0:
> drivers/usb/gadget/u_ether.c:87:21: error: expected ')' before 'uint'

That is the problem. u_ether.c lacks a "#include <linux/module.h>". It
built here because I had rndis & EEM which included that file=85

Thanks for finding this so quickly.

=46elipe, patch on top or do fix up this commit?

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
