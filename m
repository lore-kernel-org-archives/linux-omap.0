From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in resource structure
Date: Tue, 28 Sep 2010 11:45:01 -0400
Message-ID: <AANLkTim=ARtDA99XWP+RuB5nBh5FNAJHfSV34fiwtAk8@mail.gmail.com>
References: <1285201631-26266-1-git-send-email-hemahk@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E94027863D959@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36663 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0I1PpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 11:45:23 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D959@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Sep 23, 2010 at 02:32, Kalliguddi, Hema wrote:
>From: Kalliguddi, Hema
>>Modified the Omap,Blackfin and Davinci board files to add the
>>name of the IRQs
>>in the resource structures and musb driver to use the
>>get_irq_byname() api to
>>get the mc and dma irq numbers instead of using the index as
>>the order of

i dont see a problem with the existing code (going by index #), but i
dont really care either way

>>resource definition need not be always in order of device interrupt and
>>then dma interrupt

well, currently, your resource definition must always be in the order
of dev int and then dma int.  if it isnt, then i dont think musb is
going to work.

not sure why you wouldnt simply change your platform resources to
match the what the driver expects ...
-mike
