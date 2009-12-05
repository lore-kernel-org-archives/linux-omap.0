From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/20] DSPBRIDGE: driver version 0.1
Date: Sat, 5 Dec 2009 16:20:23 +0200
Message-ID: <94a0d4530912050620r1b3fca29jd742d8c98d043bd2@mail.gmail.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
	 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
	 <94a0d4530912020257h3ab5a2d8ya6a878189a92ddb3@mail.gmail.com>
	 <27F9C60D11D683428E133F85D2BB4A530426FE31AE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:46145 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbZLEOUR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 09:20:17 -0500
Received: by iwn1 with SMTP id 1so2185590iwn.33
        for <linux-omap@vger.kernel.org>; Sat, 05 Dec 2009 06:20:23 -0800 (PST)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530426FE31AE@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Wed, Dec 2, 2009 at 6:01 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
>>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>>It should be the other way around; *after* the modifications have been
>>merged,the version 0.1 would be released.
>
> Nope, version 0.2 will be once modifications are merged and branch is rebased to 2.6.32rc7

There's many problems with the current dspbridge branch, for starters
it doesn't work on the N900, nor beagleboard. Personally I would like
0.1 to work on both, and as discussed in an internal meeting I sent a
proposal for 0.1 with an analysis I did on the current branch.

>> Moreover, it would be nice
>>to get some acknowledgement from Nokia developers that the branch is
>>indeed correct.
>
> It would be nice to get them but they are not needed. As always any bug reports are welcomed.

We care about the code quality and stability, and code-reviewing
ensures that no regressions will sneak in. We reached some level of
stability on the maemo branch, and have done extensive testing on the
N900, it would be only sensible to have at least that same level of
stability on 0.1.

Currently there are many patches in the dspbridge branch that have
never been reviewed by anybody outside TI, nor tested by Nokia, so I
cannot trust that code, specially since it doesn't even work for me.

To me the whole purpose of 0.1 is to have something we can all trust
is "good", so NAK from me.

-- 
Felipe Contreras
