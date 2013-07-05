From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/5] usb: musb: dsps: use proper child nodes
Date: Fri, 05 Jul 2013 17:24:40 +0200
Message-ID: <51D6E538.3050207@linutronix.de>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de> <1373031178-8871-5-git-send-email-bigeasy@linutronix.de> <CAFqH_529D9rEJJ2rk3jGm0aGt4ZXBpP=R3azAKUxyp9vA-Nf4Q@mail.gmail.com> <51D6E2FB.3040303@linutronix.de> <CAFqH_51dW_GEx8mROjj-rGQ9D7RgrJhN2GJQfQAQ8wbj7n-0DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45725 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757373Ab3GEPYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 11:24:43 -0400
In-Reply-To: <CAFqH_51dW_GEx8mROjj-rGQ9D7RgrJhN2GJQfQAQ8wbj7n-0DQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, george.cherian@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, b-cousson@ti.com

On 07/05/2013 05:22 PM, Enric Balletbo Serra wrote:
> Fixed, I didn't update my DT for my custom board properly. Thanks.

Good. I hate breaking the compatibility for DT but unfortunately it is
beyond repair.

Sebastian

