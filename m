From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/4] dspbridge: use linux memory allocator directly
Date: Fri, 4 Sep 2009 14:17:05 +0300
Message-ID: <5ec8ebd50909040417j47abefbka1077e7f6b43b349@mail.gmail.com>
References: <1252055941-29745-1-git-send-email-andy.shevchenko@gmail.com>
	 <1252055941-29745-2-git-send-email-andy.shevchenko@gmail.com>
	 <1252055941-29745-3-git-send-email-andy.shevchenko@gmail.com>
	 <1252055941-29745-4-git-send-email-andy.shevchenko@gmail.com>
	 <4AA0F3AA.5070606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:50273 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbZIDLRE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:17:04 -0400
Received: by ewy2 with SMTP id 2so327635ewy.17
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2009 04:17:06 -0700 (PDT)
In-Reply-To: <4AA0F3AA.5070606@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-omap@vger.kernel.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Fri, Sep 4, 2009 at 2:02 PM, Artem Bityutskiy<dedekind1@gmail.com> w=
rote:

>> =C2=A0static inline struct LST_LIST *LST_Create(void)
> Would be nice to kill this whole function as well.

> I guess whole 'LST_Delete()' could go away as well?

Good point, I thought to get rid of a bit later.
Anyway, I will look into. But probably this mean to revert back to
MEM_* calls when we would like to create or destroy list head...

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
