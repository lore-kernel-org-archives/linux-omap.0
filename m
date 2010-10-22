From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: make the MGR_ENUMNODE_INFO ioctl work
Date: Sat, 23 Oct 2010 01:26:50 +0300
Message-ID: <AANLkTin_h_PrMCk96dvcdTq4jy50XtcjjXM3AacyKpdX@mail.gmail.com>
References: <1287752386-5974-1-git-send-email-ionut.nicu@mindbit.ro>
	<AANLkTim_tRKFc84e33irZuuWmrZNApH_Y2kKXBrQ4NcJ@mail.gmail.com>
	<1287760097.17937.20.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60656 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0JVW0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 18:26:51 -0400
Received: by fxm16 with SMTP id 16so1130668fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 15:26:50 -0700 (PDT)
In-Reply-To: <1287760097.17937.20.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Oct 22, 2010 at 6:08 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> On Fri, 2010-10-22 at 16:36 +0300, Felipe Contreras wrote:
>> On Fri, Oct 22, 2010 at 3:59 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
>> > The current code was always returning a non-zero status value
>> > to userspace applications when this ioctl was called.
>> >
>> > The error code was ENODATA, which isn't actually an error,
>> > it's always returned by dcd_enumerate_object() when it hits the
>> > end of list.
>> >
>> > Reorganized the code so that it works like "dynreg.out -ln" from
>> > the userspace-dspbridge package expects it to work.
>> >
>> > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
>>
>> I also found this issue, but I have simpler fix. I think my fix should
>> be applied first, and then your reorganization.
>>
>
> Yeah, mine looks more complex because of the code cleanup in
> mgr_enum_node_info().
>
> Anyway I don't have anything against applying your patch first. If your
> patch gets merged, I'll rebase my changes and submit a new one with the
> code cleanup.

Or you can put it into the next version of your patch series :)

-- 
Felipe Contreras
