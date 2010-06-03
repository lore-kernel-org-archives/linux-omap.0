From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
Date: Thu, 3 Jun 2010 17:59:10 +0300
Message-ID: <AANLkTinBMdcxzF_pZuiFHc1Eox_bYtD8PXG1OuKo0XWu@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<20100603.094022.200375421.Hiroshi.DOYU@nokia.com>
	<20100603114726.GC7127@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37436 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab0FCO7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 10:59:13 -0400
Received: by bwz11 with SMTP id 11so60514bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 07:59:11 -0700 (PDT)
In-Reply-To: <20100603114726.GC7127@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 3, 2010 at 2:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 03, 2010 at 09:40:22AM +0300, Hiroshi DOYU wrote:
>> > Felipe Contreras (14):
>> > =C2=A0 omap: mailbox: trivial whitespace cleanups
>> > =C2=A0 omap: mailbox: trivial cleanups
>
> I think folk need to read this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://lkml.org/lkml/2010/6/2/472
>
> and consider what it means for the future, and what can be done to re=
duce
> the amount of "churn".

If I have to decipher that rant, my best guess is that he is
complaining about the amount of code. If that's the case, this patch
series is only doing good:
6 files changed, 168 insertions(+), 230 deletions(-)

Another part of the rant is the fact that Linus cannot follow the huge
amount of changes. I think "trivial whitespace cleanups" pretty much
says: don't look at me if you want to be productive, while "trivial
cleanups" says, look at me if you feel like looking at easy changes.
If I were to squash these two, I think the patch series would become
harder to follow.

Something that helps in other projects, like git, is that merges are
clearly identified.

Merge branch 'linux-arm'
 Merge branch 'linux-omap'
  Merge branch 'linux-omap-mbox'
   Merge branch 'fc-cleanups'
   Merge branch 'ob-kfifo'

Then it's a bit clearer what each patch series is doing in the mailbox
tree without looking at individual patches.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
