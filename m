From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [Patchv2 0/8] DSPBRIDGE: typedef cleanup
Date: Sat, 6 Feb 2010 11:22:42 +0200
Message-ID: <5ec8ebd51002060122ybc9d51dse224b6e88f53a109@mail.gmail.com>
References: <19F8576C6E063C45BE387C64729E7394044A776231@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:53677 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab0BFJWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Feb 2010 04:22:44 -0500
Received: by ewy28 with SMTP id 28so832083ewy.28
        for <linux-omap@vger.kernel.org>; Sat, 06 Feb 2010 01:22:43 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A776231@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Sat, Feb 6, 2010 at 3:21 AM, Hebbar, Shivananda <x0hebbar@ti.com> wrote:
> Resending the patches after updating review comments and also
> Fixing some compilation breaks.

Sorry for late question, however, I fully agree with HANDLE -> void *,
but why u32 is not normal type for those changes? What do I miss?

-- 
With Best Regards,
Andy Shevchenko
