From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] amp/remoteproc: add framework for controlling remote processors
Date: Wed, 26 Oct 2011 07:25:03 +0200
Message-ID: <CAK=WgbaLcjnc1ApSwJ0zeTdjJpQzAnhYUZZ-kdtSKsHJun+FkQ@mail.gmail.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-2-git-send-email-ohad@wizery.com> <20111026051604.GT2638@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111026051604.GT2638@game.jcrosoft.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Greg KH <greg@kroah.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 26, 2011 at 7:16 AM, Jean-Christophe PLAGNIOL-VILLARD > On
STM Soc > you can upload the firmware code where you want
> the you just have to specify in 2 register where the entry point of the co-pro

great, can you provide more info ? are you using an iommu ?

> BTW do you plan to support CMA as a lot of copro will request a big
> contineuous memory to work on between the cpus.

sure, this patch set is already using CMA.

> I've to go to the ELCE will continue the review later

come to "Tycho" today at 11:45 :)

Thanks,
Ohad.
