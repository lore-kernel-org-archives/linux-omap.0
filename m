From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: Re: Patch missing in 2.6.32-rc1
Date: Wed, 30 Sep 2009 00:52:55 +0100
Message-ID: <3d374d00909291652m3f52fbf6y1ea45ac7bec99018@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com>
	 <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD1AD8FB@dbde02.ent.ti.com>
	 <20090819131752.GC7629@atomide.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3F19@dbde02.ent.ti.com>
	 <20090929203525.GF16865@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:50680 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbZI2Xww convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 19:52:52 -0400
Received: by bwz6 with SMTP id 6so2432832bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 16:52:55 -0700 (PDT)
In-Reply-To: <20090929203525.GF16865@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/9/29 Tony Lindgren <tony@atomide.com>:
> * Premi, Sanjeev <premi@ti.com> [090929 04:34]:
>> Hi Tony,
>>
>> Can you push this patch to 2.6.32-rc1?
>>
>> 7a8d53a0: =A0arch: arm: omap: terminate ifndef
>>
>> I was unable to refresh my patches against this baseline.
>> OR, is it okay if I re-submit against the 'master'.
>
> Sorry, I was meaning to look where the mismatch really came
> from but forgot.
>
> Looks like adding omap850 support added an #else without removing
> the #endif above it, and also removed another #endif in commit
> ae302f40061235f6bc58ae9ba02aa849d60223b5.

The #else immediately after the removed #endif needs to go as well,
because the block that the #endif(s) belongs to already has an #else.

That means the bug not only caused everything after the extra #endif
to have no multiple inclusion protection (causing the redefinitions),
but the extra #else also caused cpu_is_omap850() to be true only when
cpu.h was included twice.

Thanks,
--=20
Alistair Buxton
a.j.buxton@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
