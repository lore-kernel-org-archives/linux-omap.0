From: Kees Cook <keescook@chromium.org>
Subject: Re: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Sun, 15 Apr 2018 11:00:06 -0700
Message-ID: <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
References: <20180404165559.4cd0c12c@canb.auug.org.au> <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com> <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com> <20180404201837.GA9710@amd> <20180415173908.GA2024@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180415173908.GA2024@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Daniel Micay <danielmicay@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?B?TWlja3Vsw6HFoSBRd2VydHo=?= <abcloriens@gmail.com>, Clayton Craft <clayton@craftyguy.net>, Martijn Braam <martijn@brixit.nl>, Sakari
List-Id: linux-omap@vger.kernel.org

On Sun, Apr 15, 2018 at 10:39 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Thanks.
>>
>> Ok, let me try to bisect it. Compile-problem should be easy...
>>
>> Hmm. And as it is compile-problem in single file, it should even be
>> reasonably fast. I did not realize how easy it would be:
>>
>> #!/bin/bash
>> set -e
>> cp config.ok .config
>> yes '' | ARCH=arm make lib/string.o
>>
>> And the winner is:
>>
>> ee333554fed55555a986a90bb097ac7f9d6f05bf is the first bad commit
>> commit ee333554fed55555a986a90bb097ac7f9d6f05bf
>> Author: Jinbum Park <jinb.park7@gmail.com>
>> Date:   Tue Mar 6 01:39:24 2018 +0100
> ...
>
>>     Acked-by: Kees Cook <keescook@chromium.org>
>>     Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
>>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> So I bisect a problem in -next, and patch is merged to Linus,
> _anyway_, breaking compilation there? Neither Jinbum nor Russell even
> bother to comment.

Hi! Sorry I lost this email in my inbox. It seems this is specific to
a particular subset of arm architectures? (My local builds of arm all
succeed, for example. Can you send your failing config?) I'll take a
closer look on Monday if Daniel doesn't beat me to it.

-Kees

>
> And BTW, Russell, there's another regression I bisected to your
> commit, that one is like two releases old, and "only" causes
> compilation warnings during build with non-US locale. I even proposed
> fix for that. Guess what? Ignored too.
>
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Kees Cook
Pixel Security
