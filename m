From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: Add minimal OMAP5 SOC support for 3.6
Date: Tue, 7 Aug 2012 12:46:32 +0530
Message-ID: <CAMQu2gw14uCAsobTd3MQPeLkBsxB=h1qwrLQB-WdEh0P4kfp+Q@mail.gmail.com>
References: <1341846143-11137-1-git-send-email-santosh.shilimkar@ti.com>
 <20120710083354.GM1122@atomide.com> <CAMQu2gwNeYUm7iL+30wwoHCNGZ3dXF2k+w-PE=tw-pMSO9F3NQ@mail.gmail.com>
 <20120807070056.GI11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55940 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862Ab2HGHQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:16:55 -0400
Received: by ghrr13 with SMTP id r13so2317676ghr.27
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 00:16:53 -0700 (PDT)
In-Reply-To: <20120807070056.GI11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, Aug 7, 2012 at 12:30 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120726 00:27]:
>> On Tue, Jul 10, 2012 at 10:33 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [120709 08:07]:
>> >> Tony,
>> >>
>> >> Please pull below OMAP5 SOC minimal support. It is generated against the
>> >> cleanup-part2 branch of yours. As you suggested, I have dropped CK_54XX
>> >> flag changes to avoid conflicts.
>> >
>> > OK seems to merge fine now, pulled into devel-omap5.
>> >
>> Now OMAP5 support appearing in mainline. In case you would like
>> to boot mainline on your OMAP5 board, you need to merge a
>> OMAP5 SOC hwmod/clock data which is out of tree. I have
>> put that on a branch and same is available [1]. Please note
>> that the only DT boot supported.
>
> Nice to see it being a small set :) Have these changes been
> posted to the mailing lists for review?
>
Not yet. Benoit was looking into the database difference between
the current and next version of the silicon. Since there is a difference
between the data, the idea was to submit the final version of data to
avoid potential huge patching.

Regards
santosh

>
>
>> [1] git://github.com/SantoshShilimkar/linux.git out-of-tree/omap5-data
