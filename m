From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] Two trivial omap/serial patches
Date: Tue, 21 Feb 2012 11:10:30 -0800
Message-ID: <87boos57fd.fsf@ti.com>
References: <20120219022841.8254.86264.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120219022841.8254.86264.stgit@notabene.brown> (NeilBrown's
	message of "Sun, 19 Feb 2012 13:29:31 +1100")
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, "Govindraj . R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

NeilBrown <neilb@suse.de> writes:

> Just a couple of small clean-ups following the recent major changes.

Thanks Neil.

I'll queue these as cleanups for v3.4 since I dont' think they're v3.3
material at this point of the cycle.

I'll also update the changelogs to follow the practice of adding the
shortlog in parens after the commit ID.

Kevin


>
> Thanks,
> NeilBrown
>
> ---
>
> NeilBrown (2):
>       ARM: OMAP2: remove some orphan function declarations.
>       ARM: OMAP2+: UART: remove unused fields in omap_uart_state.
>
>
>  arch/arm/mach-omap2/pm.h                 |    1 -
>  arch/arm/mach-omap2/serial.c             |    4 ----
>  arch/arm/plat-omap/include/plat/serial.h |    1 -
>  3 files changed, 0 insertions(+), 6 deletions(-)
