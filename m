From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] watchdog: omap_wdt: convert to new watchdog core
Date: Fri, 7 Sep 2012 22:29:23 +0300
Message-ID: <20120907192923.GA16586@bitmer.com>
References: <1346769684-25543-1-git-send-email-aaro.koskinen@iki.fi>
 <20120907133107.GA14585@bitmer.com>
 <20120907155143.GA10099@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120907155143.GA10099@harshnoise.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 07, 2012 at 06:51:43PM +0300, Aaro Koskinen wrote:
 
> Thanks for the report! I'll look into this and test with other
> Nokia boards. I tested the patch only with N800 and v3.6-rc4
> (4cbe5a555fa58a79b6ecbb6c531b8bab0650778d) and did not see any issues
> with normal use cases (boot, watchdog open, feeding, watchdog close).
>
I forgot to test on another hw but will try to do in coming days. Anyway I'm
happy to test your patch again if you spot something so you could cc also me
for retesting.

-- 
Jarkko
