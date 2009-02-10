From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: musb OTG broken in 2.6.29-rc3?
Date: Mon, 9 Feb 2009 20:43:12 -0800
Message-ID: <5e088bd90902092043u913d35axe658e784d4befb59@mail.gmail.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:42250 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZBJEnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 23:43:15 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1668590fkf.5
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2009 20:43:13 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Mon, Feb 9, 2009 at 8:05 PM, Gupta, Ajay Kumar <ajay.gupta@ti.com> wrote:

>> Before I spend too much time debugging, has anyone else been
>> successful with musb OTG in 2.6.29-rc3?  A quick search of this list
>> didn't turn up any discussion of issues.
>
> It works fine on OMAP35x EVM too. I had to add a proc entry for session start
> (Switching on the vBus).

Could you give me a little more detail on what you had to do for
session start?  Perhaps I have a similar issue on Overo.

Thanks!

Steve
