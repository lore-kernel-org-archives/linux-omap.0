From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Android on N810 File System Problem
Date: Mon, 12 May 2008 14:32:17 +0200
Message-ID: <482838D1.20301@googlemail.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com> <48116F5C.9040009@googlemail.com> <20080425183605.GA27479@kedavra.cpe.vivax.com.br> <87fxt7my4o.fsf@nokia.com> <20080427223248.GA5962@kedavra.cpe.vivax.com.br> <20080428233827.GE8449@atomide.com> <20080429090032.GA25363@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:39384 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbYELMbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 08:31:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1780658fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2008 05:31:23 -0700 (PDT)
In-Reply-To: <20080429090032.GA25363@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Kalle Valo <kalle.valo@nokia.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

Brian Swetland wrote:
> [Tony Lindgren <tony@atomide.com>]
> 
>>I've merged Jarkko's asoc patch to linux-omap for testing. Have not
>>gotten any sound out of it on my n810 though.. Maybe some alsamixer
>>settings issue?
>>
>>Kalle, do you have any tips on getting WLAN to work on n8x0?
> 
> This was the show-stopper for me.  When I last got things hobbling
> along on n8x0, the binary-only wlan module was incompatible with
> newer kernels than 2.6.21 (changes in some network data structures).
> 
> The newer android builds expect 2.6.24 or more recent.  I'm hoping
> that Nokia will release a newer build of the wlan module for 2.6.24
> at some point.  That'd be a big motivator for me to spend time hacking
> on the platform again.

Have a look to the section

-- cut --
...

In the end I think what would be realistically possible ...
is that Nokia provides one person whose sole task is to support the
community by mantaining the closed code and providing new binaries that
link against recent libraries. The community would still be able to set
the direction for the development and ask for updates, so that these
closed areas would not hold back work done in the open part. Which is
the majority.

...
-- cut --

of

http://lists.maemo.org/pipermail//maemo-developers/2008-May/017556.html

Maybe you "as community" should "ask for updates" on maemo-developers 
list?

Dirk
