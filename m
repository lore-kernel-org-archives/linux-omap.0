From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 16 Dec 2011 20:43:22 +0530
Message-ID: <CAMQu2gxNvrMXYs0gPYTS3wUL=toL=ccRxso25esXwmx9j4O5fg@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVNOpfWxod_pN-kiQPoQ7n=XSFeV6WK6sf+8hYSiZ2rDBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:44091 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756363Ab1LPPNp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 10:13:45 -0500
Received: by mail-qw0-f48.google.com with SMTP id c16so2358569qad.14
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 07:13:43 -0800 (PST)
In-Reply-To: <CACVXFVNOpfWxod_pN-kiQPoQ7n=XSFeV6WK6sf+8hYSiZ2rDBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

On Fri, Dec 16, 2011 at 7:20 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>
>> [1], add static dependency
>
> Sorry for the mess, see attachment for the change.
>
Your patch is setting static dependency between ISS and l3_2.
It's not dynamic dep. Dynamic dep is managed through hardware and they
are not configurable. But with static dep. you can over-ride that behavior
as you have done.

This will impact power since l3_2 can't idle as long as iss clock
domain is active.

I need to check internal code-base but I don't remember this
issue observed so far.

Regards
Santosh
