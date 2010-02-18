From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Patch[0/2]:DSPBRIDGE: Excessive u32 Cleanup
Date: Thu, 18 Feb 2010 22:17:36 +0200
Message-ID: <5ec8ebd51002181217k420d0e90mfab40e8161cce25f@mail.gmail.com>
References: <19F8576C6E063C45BE387C64729E7394044D71B418@dbde02.ent.ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0C0130EBC2DF@dlee02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E7394044D71B420@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:53903 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697Ab0BRURi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 15:17:38 -0500
Received: by ey-out-2122.google.com with SMTP id d26so2141979eyd.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 12:17:36 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044D71B420@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Feb 18, 2010 at 10:10 PM, Hebbar, Shivananda <x0hebbar@ti.com> wrote:
>> What is the motivation of this change?
> Sometime back ,there was comment on excessive u32ypes used in bridge.
> http://marc.info/?l=linux-omap&m=123998339213416&w=2
I respect Artem for his work, but his personal hate of u* types not a
reason to bring some useless patches.

Look:
[andy@localhost linux-2.6]$ git grep -n -w u32 | wc
  76327  388062 5253203

I guess you don't need further exlanations here.

-- 
With Best Regards,
Andy Shevchenko
