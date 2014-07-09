From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 1/4] tty: serial: 8250 core: provide a function to
 export uart_8250_port
Date: Wed, 09 Jul 2014 19:23:41 +0200
Message-ID: <53BD7A9D.2070605@linutronix.de>
References: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de> <20140707140911.5ee517d2@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43488 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaGIRXs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 13:23:48 -0400
In-Reply-To: <20140707140911.5ee517d2@alan.etchedpixels.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On 07/07/2014 03:09 PM, One Thousand Gnomes wrote:
> Please update the patch to clearly describe the locking
> assumptions/requirements for the caller (and not to use it unless you
> have no other choice)

done.

Sebastian
