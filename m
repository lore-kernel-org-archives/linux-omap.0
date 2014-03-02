From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
Date: Sun, 2 Mar 2014 07:14:51 +0200
Message-ID: <CAK=WgbY0wDtGCm71E8VXi2g5+VcGogHEy8jdekTRg8xtp6-3rQ@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-5-git-send-email-s-anna@ti.com> <CAJAp7Oi7wD+VsMAd37gT04yZ4TH4ygXFmheDhvmWuanUjpBmVQ@mail.gmail.com>
 <52F92524.3080402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:45140 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaCBFPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 00:15:13 -0500
Received: by mail-la0-f43.google.com with SMTP id e16so3614017lan.30
        for <linux-omap@vger.kernel.org>; Sat, 01 Mar 2014 21:15:12 -0800 (PST)
In-Reply-To: <52F92524.3080402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Bjorn Andersson <bjorn@kryo.se>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

On Mon, Feb 10, 2014 at 9:14 PM, Suman Anna <s-anna@ti.com> wrote:
> On 02/07/2014 04:49 PM, Bjorn Andersson wrote:
>> It seems to be standard practice to pass the error value back to the
>> consumer, so you should
>> return ERR_PTR(ret); here instead of the NULL...
>
>
> I have modelled the return values in this function based on the return
> values in the existing hwspin_lock_request interfaces. I would need to
> change those functions as well.
>
> Ohad,
> Do you have any objections to the return code convention change?

Unless strictly needed, I prefer we don't switch to the ERR_PTR code
convention, as it reduces code readability and increases chances of
user bugs.

In our case, switching to ERR_PTR and friends seems only to optimize a
few error paths, and I'm not sure it's a big win over simplicity.

Thanks,
Ohad.
