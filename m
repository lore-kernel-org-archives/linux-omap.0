From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] am33xx: create child nodes for the two musb controllers
Date: Thu, 27 Jun 2013 09:31:34 +0200
Message-ID: <51CBEA56.4010806@linutronix.de>
References: <20130626153325.GA24075@linutronix.de> <20130627065150.GK15455@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39265 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab3F0Hbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 03:31:36 -0400
In-Reply-To: <20130627065150.GK15455@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Benoit Cousson <b-cousson@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 06/27/2013 08:51 AM, Felipe Balbi wrote:
> Hi,

Hi Felipe,

> the patch is alright, but what about the giant amoutn of function 
> pointers we have ? Are you planning to use of_dev_auxdata ??

I didn't plan to use of_dev_auxdata. What do you mean by "giant amount
of function pointers"?

Sebastian
