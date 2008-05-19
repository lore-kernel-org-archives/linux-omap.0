From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 0/2] MUSB: 2 patches to fix some bug found on Blackfin
Date: Mon, 19 May 2008 14:39:10 +0800
Message-ID: <386072610805182339n2e141b83q4b8f9804194088e4@mail.gmail.com>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org>
	 <200805170737.37806.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:4317 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYESGjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2008 02:39:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1032085ywe.1
        for <linux-omap@vger.kernel.org>; Sun, 18 May 2008 23:39:10 -0700 (PDT)
In-Reply-To: <200805170737.37806.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 17, 2008 at 10:37 PM, David Brownell <david-b@pacbell.net> wrote:
> On Saturday 17 May 2008, Bryan Wu wrote:
>>
>> We discussed these 4 bugs before. Now we fixed them.
>> Please review following 2 patches.
>
> They looked plausible to me ... though the urb->status
> one is a bit of a band-aid, and when that field finally
> vanishes a better fix will be needed.
>

OK, so is there any plan for merge the MUSB to mainline and finally to
remove the urb->status?

-Bryan
