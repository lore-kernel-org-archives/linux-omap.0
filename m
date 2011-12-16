From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 16 Dec 2011 23:46:20 +0800
Message-ID: <CACVXFVNw1ni63Pk-SxaykTjMS4Qm0_9wtt8=DXypoKwfUiA2ig@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
	<CACVXFVNOpfWxod_pN-kiQPoQ7n=XSFeV6WK6sf+8hYSiZ2rDBA@mail.gmail.com>
	<CAMQu2gxNvrMXYs0gPYTS3wUL=toL=ccRxso25esXwmx9j4O5fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33528 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759815Ab1LPPqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 10:46:21 -0500
Received: by faar15 with SMTP id r15so3046357faa.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 07:46:20 -0800 (PST)
In-Reply-To: <CAMQu2gxNvrMXYs0gPYTS3wUL=toL=ccRxso25esXwmx9j4O5fg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

On Fri, Dec 16, 2011 at 11:13 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Dec 16, 2011 at 7:20 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> Hi,
>>
>> On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>>
>>> [1], add static dependency
>>
>> Sorry for the mess, see attachment for the change.
>>
> Your patch is setting static dependency between ISS and l3_2.
> It's not dynamic dep. Dynamic dep is managed through hardware and they

Yes, I see now,  L3_2_DYNDEP of CM_CAM_DYNAMICDEP is read only.

> are not configurable. But with static dep. you can over-ride that behavior
> as you have done.
>
> This will impact power since l3_2 can't idle as long as iss clock
> domain is active.
>
> I need to check internal code-base but I don't remember this
> issue observed so far.

In fact, I saw the issue on 3.2.0-rc5-next-20111216, and even
no such issue on 3.2.0-rc5.  After some bisecting, I found below
is the first commit on which the issue can be observed:

commit 3c50729b3fa1cd8ca1f347e6caf1081204cf1a7c
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date:   Wed Jan 5 22:03:17 2011 +0530

    ARM: OMAP4: PM: Initialise all the clockdomains to supported states

    Initialise hardware supervised mode for all clockdomains if it's
    supported. Initiate sleep transition for other clockdomains,
    if they are not being used.


thanks,
-- 
Ming Lei
