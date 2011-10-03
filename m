From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/30] ARM/omap: omap specific randconfig fixes
Date: Mon, 03 Oct 2011 10:35:25 +0530
Message-ID: <4E894295.5000608@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Arnd,

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> Hi Tony,
> 
> I've mentioned these patches before, and now I've managed to
> go through them again and clean them enough for submission.
> 
> If nobody has any objections, I would like to send them to
> Linus in the coming merge window, otherwise it would be nice
> if you could pick the ones that look good to you and send
> me a pull request. If any of these look like they should be
> backported to stable kernels, please tell me and I'll add
> a cc:stable@k.o tag.
> 
> The entire set is also available from
>  git pull git://git.linaro.org/people/arnd/arm-soc.git randconfig/omap
> 
> but I have not yet pulled them into the for-next branch.
> 
Do you have any scripts to create these randconfigs ?
These are useful to run on newer set of patches also to get all
builds right first place.

Regards
Santosh
