From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Commit 09d28d2c19 introduces set-after-free in arch/arm/mach-omap2/mcbsp.c
Date: Mon, 12 Dec 2011 10:15:18 +0200
Message-ID: <4EE5B816.4060607@bitmer.com>
References: <20111211170813.02fd478a@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111211170813.02fd478a@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/11/2011 08:08 AM, NeilBrown wrote:
> Should these settings just be moved up before the call to
> omap_device_build_ss?? Doing that removes 
> [    0.196014] Slab corruption: size-32 start=ded3edc0, len=32
> warning.
>
Good catch! Yes, they must be set before omap_device_build_ss and
definitely before kfree. I just wonder how did I managed to put them
after both. Perhaps my own rebasing error or just plain stupidity...
I'll send a patch soon.

-- 
Jarkko
