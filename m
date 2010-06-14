From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 14 Jun 2010 20:47:37 +0300
Message-ID: <AANLkTimQwF_gia70cPDGUF_Aef2d7XJiXTo8VkuPMsMF@mail.gmail.com>
References: <AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
	<20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
	<AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
	<20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:47821 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809Ab0FNRrj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 13:47:39 -0400
Received: by ey-out-2122.google.com with SMTP id 25so739197eya.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 10:47:37 -0700 (PDT)
In-Reply-To: <20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: fernando.lugo@ti.com, ohad@wizery.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

On Mon, Jun 14, 2010 at 11:58 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
>> * Let's make sure no one accidentally registers two receivers on the
>> same time (which would result in one overwriting the other's callback
>> field).
>
> I'd like to allow mutiple listners in some way, as the flexibility of
> mailbox functionalty.

Can you explain a use case? If there's no good argument for
complexity, I would rather go for simplicity.

-- 
Felipe Contreras
