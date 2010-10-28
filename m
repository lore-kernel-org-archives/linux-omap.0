From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP: AM3517/05: Add craneboard support
Date: Thu, 28 Oct 2010 01:52:35 -0500
Message-ID: <4CC91DB3.1050401@ti.com>
References: <1288017943-6651-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53038 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab0J1Gwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 02:52:38 -0400
In-Reply-To: <1288017943-6651-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kridner, Jason" <jdk@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "nagendra@mistralsolutions.com" <nagendra@mistralsolutions.com>, "umeshk@mistralsolutions.com" <umeshk@mistralsolutions.com>

Hi,
Looking much better now, thanks.

Few suggestion, not usually well documented, but a convention nevertheless:

$subject: might be a good idea to do the following for revision of patch
original patch [PATCH] is considered v1
next revision such as this is considered v2 [PATCH v2] is useful for 
people to keep track of the revision of patch under discussion.

when you post with git send-email especially in a follow on patch, add 
--in-reply-to "Original patch subject" - this helps mail readers like 
gmail/thunderbird etc to properly group them up for the receiver. 
Honestly, I forget to do this most of the time, but is a good practice 
to have nonetheless.

srinath@mistralsolutions.com had written, on 10/25/2010 09:45 AM, the 
following:
> From: Srinath <srinath@mistralsolutions.com>
> 
> This patch adds basic board file. Detailed support will follow in
> subsequent patches.
> 
>       [1] http://www.ti.com/sitara
>       [2] http://www.mistralsolutions.com/products/craneboard.php

Look at other board file addition examples - for example:
IGEP - commit ID: 58e111621d402d41cb0cabae7c532d6194b7d943

it gives a brief description of
a) what the board is
b) overall resemblance to other boards
c) idea about the family of silicon involved

when you give a link - we in the linux-omap probably have heard about 
sitara family of processors, but the patch needs to go down to linux-arm 
and lkml - where progressively, the processor is not probably not that 
well heard of :). it might be nice to state OMAP3 family of processors 
to give the reviewer an idea about what is being talked about.

http://omapedia.org/wiki/Releasing_to_Linux_kernel_using_patches_and_emails#Note_on_git_commit_comments
See the point on "Suggestions for Commit messages:"

> 
> This patch has been created against omap-next branch.
This is not something you'd like to see in kernel.org commit message 
right? this is the type of info which could easily fit into diffstat 
section.

> 
> Signed-off-by: Srinath <srinath@mistralsolutions.com>
> ---
this side of the patch is called the diffstat - >from here to the first 
diff does not get into the git history when committed with git am - so 
we can add quiet a few things here

Since this is v2 of the patch series, few suggestions
a) "This patch has been created against omap-next branch" is nice thing 
to do -> keep in mind, with omap-for-linus being merged to kernel.org, 
you may want to base further changes on kernel.org - but if you state 
something to the maintainer, this is the place to do it
b) when you post v2 of a patch, keep in mind you'd like to help a reader 
who might have missed reviewing your previous patch to review this one 
in context to the previous patches as well.. at least the rule I try to 
follow is to have the diffstat of a later series contain details as follows:
v2: change 1
     change 2
     did not do change 3 - reason why..

v1: link of the discussion, I prefer using marc.info as it can give me a 
complete thread easily, for example, I'd post a link like this:
http://marc.info/?t=128801458500004&r=1&w=2

Reason for doing this:
a) having additional reviewers improves your code
b) for an old reviewer, v2 sections tell him/her what has changed and he 
can focus to those changes alone, rest he has already seen
b) for a new reviewer, v1 gives a context of previous discussion, v2 
tells him/her what actions where taken by the author as a result and 
provide comments in reference to that.

Note: this is a bit of a pain as the patch goes through multiple 
iterations, but as far as I saw, it has at least helped my patches at 
times :).

>  arch/arm/configs/omap2plus_defconfig         |    1 +
>  arch/arm/mach-omap2/Kconfig                  |    5 ++
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/board-am3517crane.c      |   70 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  5 files changed, 79 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am3517crane.c
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index ccedde1..8c93f86 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -40,6 +40,7 @@ CONFIG_MACH_OMAP_LDP=y
>  CONFIG_MACH_OVERO=y
>  CONFIG_MACH_OMAP3EVM=y
>  CONFIG_MACH_OMAP3517EVM=y
> +CONFIG_MACH_CRANEBOARD=y
>  CONFIG_MACH_OMAP3_PANDORA=y
>  CONFIG_MACH_OMAP3_TOUCHBOOK=y
>  CONFIG_MACH_OMAP_3430SDP=y

I suggest you drop this change -> leave it to Tony when he creates his 
usual defconfig cleanups :)

look at commit ids:
58e111621d402d41cb0cabae7c532d6194b7d943 - IGEP board
b075f58b2c0f377b4bfbe11b817e003393bcb489 - PandaBoard
for examples how the board introductions have been done recently.

[...]
rest looks ok to me.

-- 
Regards,
Nishanth Menon
