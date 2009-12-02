From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: SR1: VDD autocomp is not active
Date: Wed, 2 Dec 2009 15:04:38 +0300
Message-ID: <48239d390912020404w1c333178o2315119d7e53a2dc@mail.gmail.com>
References: <48239d390912010353l44f8e6d9w7ff963c7fb41ecf3@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB1@dbde02.ent.ti.com>
	 <48239d390912010904r25b7246bx529b5132c65ef46a@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DF@dbde02.ent.ti.com>
	 <48239d390912011223yf2ffa2bhe43a6b699b9f6655@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE87A5E9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42596 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZLBMEd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 07:04:33 -0500
Received: by ewy19 with SMTP id 19so139456ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 04:04:38 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE87A5E9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi, all! It seems discussion went off-list somehow, so I won't delete
some quoting.

On Wed, Dec 2, 2009 at 2:38 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: Sergey Lapin [mailto:slapinid@gmail.com]
>> Sent: Wednesday, December 02, 2009 1:54 AM
>> To: Premi, Sanjeev
>> Subject: Re: SR1: VDD autocomp is not active
>>
>> > I did notice an earlier mail where you mentioned about
>> using an older
>> > kernel version. have to back-ported patches specific to silicon
>> > identification on this kernel/
>> I use PM branch of linux-omap git.
>> I just need to make my patches less disgusting by properly
>> porting these.
>> Actually now I think I could do this work even without
>> appropriate tree, since
>> amount of patches is not that big and API is not too different.  These
>> patches are
>> not required to make board basically run.
>>
>> >
>> > It appears that efuse data required for SmartReflex to work may not
>> > be available on this silicon... leading to these messages.
>> >
>> > Right now, I am away from source code, will be able to verify in the
>> > morning.
>> Thanks, looking forward for your reply.
>
> You should try this with an ES3.1 silicon. If sr_enable() fails, we might
> see this issue.
It seems I only have ES2.1 silicon, so what should I do
- disable SR functionality at all
- somehow set values the other way?
It seems SR is possible on this silicon, only efuse data are absent,
so is there a way I could somehow fake these (with some known working values),
so the stuff works?

Thanks a lot,
S.



>
>>
>> S.
>>
