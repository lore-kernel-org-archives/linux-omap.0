From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: Add minimal OMAP5 SOC support for 3.6
Date: Thu, 26 Jul 2012 09:22:07 +0200
Message-ID: <CAMQu2gwNeYUm7iL+30wwoHCNGZ3dXF2k+w-PE=tw-pMSO9F3NQ@mail.gmail.com>
References: <1341846143-11137-1-git-send-email-santosh.shilimkar@ti.com> <20120710083354.GM1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:54722 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750946Ab2GZHW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 03:22:29 -0400
Received: by yenr9 with SMTP id r9so2033418yen.22
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 00:22:28 -0700 (PDT)
In-Reply-To: <20120710083354.GM1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On Tue, Jul 10, 2012 at 10:33 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120709 08:07]:
>> Tony,
>>
>> Please pull below OMAP5 SOC minimal support. It is generated against the
>> cleanup-part2 branch of yours. As you suggested, I have dropped CK_54XX
>> flag changes to avoid conflicts.
>
> OK seems to merge fine now, pulled into devel-omap5.
>
Now OMAP5 support appearing in mainline. In case you would like
to boot mainline on your OMAP5 board, you need to merge a
OMAP5 SOC hwmod/clock data which is out of tree. I have
put that on a branch and same is available [1]. Please note
that the only DT boot supported.

Regards
Santosh

[1] git://github.com/SantoshShilimkar/linux.git
out-of-tree/omap5-data
