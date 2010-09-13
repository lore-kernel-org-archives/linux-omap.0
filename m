From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Mon, 13 Sep 2010 20:26:52 +0400
Message-ID: <4C8E50CC.3080705@ru.mvista.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com>	<1283873014-32511-6-git-send-email-tom.leiming@gmail.com>	<4C8E18AD.8000502@ru.mvista.com> <AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com> <4C8E4882.6040600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42886 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0IMQ1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 12:27:40 -0400
In-Reply-To: <4C8E4882.6040600@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Ming Lei <tom.leiming@gmail.com>, greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>

Hello.

I wrote:

>>>   But why not modify the conditional above all that code, just excluding
>>> 'is_dma' from it. This conditional already includes (request->actual ==
>>> request->length) check. Please recast this patch.

>> The two condition is OR relation, not and, so we can't exclude 
>> 'is_dma' simply.

>    Yes, we can. You're clearly handling only the DMA case with your 
> added check, the PIO case was already handled.

>> Anyway, the change is not wrong, right?

>    Not wrong, but the check is duplicate.

    Oops, I've been too fast and haven't realized that the check done here _is_ 
actually wrong. It causes ZLP send to trigger too fast in the DMA case. So 
please fix this patch. Felipe, please drop it for now.

WBR, Sergei
