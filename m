From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: tsc2007: fix locking method against the current rc kernel
Date: Mon, 11 May 2009 18:50:00 -0700
Message-ID: <200905111850.01096.dmitry.torokhov@gmail.com>
References: <483a38b80905110441t703adbd6sab31bcf19b507fc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:7147 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbZELBuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 21:50:09 -0400
In-Reply-To: <483a38b80905110441t703adbd6sab31bcf19b507fc9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Kwangwoo,

On Monday 11 May 2009 04:41:35 Kwangwoo Lee wrote:
> Hi Dmitry,
>
> The following patch fixes bug in tsc2007.
> It is not working correctly in the current rc kernels.
> IMHO, this patch should go in the 2.6.30
>

I agree, it is in my for-linus branch now.

> Can you advise me about "From: email" part?
> I splited Thierry's patch. So the original "From: email" is followed:
>
> From: Thierry Reding <thierry.reding@avionic-design.de>
>
> Thank you,
> Kwangwoo Lee
>
> From 749ee3a4a2c2fe1f41601481e47cb26d8ccec20d Mon Sep 17 00:00:00 2001
> From: Kwangwoo Lee <kwangwoo.lee@gmail.com>

This is the last "from" tag in the e-mail so my scripts picked that up.
I adjusted the commit so now it shows Thierry as the original author.

Thanks.

-- 
Dmitry
