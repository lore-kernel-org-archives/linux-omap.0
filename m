From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/7] mfd: ab8500-debugfs: Prevent initialised field from being over-written
Date: Thu, 15 Sep 2016 13:31:28 +0200
Message-ID: <10514464.46kyQp39gL@wuerfel>
References: <20160915104521.14286-1-lee.jones@linaro.org> <20160915104521.14286-3-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-3-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday, September 15, 2016 11:45:16 AM CEST Lee Jones wrote:
> Due to the lack of parity in the way array fields have been named/
> numbered, a mistake was made where more debug fields were declared
> than actually existed.  In doing so, 2 fields were added, which
> although unclear, were already declared in the array.  The result
> was that the latter declarations trashed the former ones.
> 
> This patch places the array back in the correct order and removes
> the offending NULL entries.
> 
> While we're at it, let's ensure this doesn't happen again by naming
> each field properly and add a new *_LAST define to describe how
> many fields there should be.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-debugfs.c      | 50 ++++++++++++++++-----------------------
>  include/linux/mfd/abx500/ab8500.h |  2 ++
>  2 files changed, 23 insertions(+), 29 deletions(-)

I tried doing the same thing at some point and never submitted.
For reference, here is my version. Yours looks better though,
so keep that.

	Arnd

commit daa445be130176d946af78e7a8460e44d3a792dd
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Jun 8 10:29:18 2016 +0200

    mfd: ab8500: remove duplicate table entries
    
    gcc -Wextra finds two duplicate initializations for ab8500_debug_ranges:
    
    drivers/mfd/ab8500-debugfs.c:466:11: error: initialized field overwritten [-Werror=override-init]
    drivers/mfd/ab8500-debugfs.c:466:11: note: (near initialization for 'ab8500_debug_ranges[17]')
    drivers/mfd/ab8500-debugfs.c:470:11: error: initialized field overwritten [-Werror=override-init]
    drivers/mfd/ab8500-debugfs.c:470:11: note: (near initialization for 'ab8500_debug_ranges[18]')
    
    In both cases, one initialization looks valid, the other one overrides
    it with an empty one. I'm removing the empty overrides now, assuming
    they were not intentional.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 0aecd7bd35f8..c23104b277c4 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -463,14 +463,6 @@ static struct ab8500_prcmu_ranges ab8500_debug_ranges[AB8500_NUM_BANKS] = {
 			},
 		},
 	},
-	[0x11] = {
-		.num_ranges = 0,
-		.range = NULL,
-	},
-	[0x12] = {
-		.num_ranges = 0,
-		.range = NULL,
-	},
 	[0x13] = {
 		.num_ranges = 0,
 		.range = NULL,
