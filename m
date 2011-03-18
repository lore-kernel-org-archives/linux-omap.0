From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 17 Mar 2011 20:02:33 -0700
Message-ID: <AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110317183048.GW7258@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 17, 2011 at 11:30 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> Please pull omap changes for this merge window from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-for-linus

Btw, that "generic hardware spinlock" thing needs to be hidden from
sane people and architectures that don't need it.

Make platforms that need it "select" it or something. It looks like
nobody but an OMAP4 could _possibly_ ever want to answer 'y' to that
question, SO DON'T ASK IT!

                     Linus
