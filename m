From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP3: enabling CPU idle leads to panic
Date: Wed, 25 Nov 2009 09:31:18 -0800
Message-ID: <87iqcyh5p5.fsf@deeprootsystems.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
	<873a43wzfm.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
	<48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:44171 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758142AbZKYRbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 12:31:14 -0500
Received: by pzk1 with SMTP id 1so5773331pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 09:31:20 -0800 (PST)
In-Reply-To: <48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com> (Sergey Lapin's message of "Wed\, 25 Nov 2009 18\:37\:52 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sergey Lapin <slapinid@gmail.com> writes:

> On Tue, Nov 24, 2009 at 11:21 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> From: Kevin Hilman [khilman@deeprootsystems.com]
>> Sent: Tuesday, November 24, 2009 11:57 PM
>> To: Sergey Lapin; Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: OMAP3: enabling CPU idle leads to panic
>>
>> Sergey Lapin <slapinid@gmail.com> writes:
>>
>>> I use PM branch merged with linux-omap branch.
>>
>> Not sure what this means.  PM branch is already based at linux-omap
>> master branch.  You'll need to be more specific, ideally with commit
>> IDs.
>
> I do git branch tmp origin/master
> git checkout -f tmp
> git merge origin/pm

The pm branch is already based on l-o master, but perhaps not the very
latest.  Instead of the above can you just do

git branch tmp origin/pm
git checkout -f tmp

> git merge origin/mybranch

It might if you base your 'mybranch' at the same merge point that the
pm branch is based at.  You can find the merge point using:

git merge-base origin/master origin/pm

Kevin
