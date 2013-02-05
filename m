From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: SoC name and revision unification
Date: Tue, 5 Feb 2013 15:56:26 -0800
Message-ID: <20130205235626.GS25185@atomide.com>
References: <1359660284-5225-1-git-send-email-ruslan.bilovol@ti.com>
 <1359660284-5225-2-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359660284-5225-2-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130131 11:28]:
> This is a long story where for each new generation of
> OMAP we used different approaches for creating
> strings for SoCs names and revisions that this patch
> fixes. It makes future exporting of this information
> to SoC infrastructure easier.

Maybe use name soc_name and soc_rev instead and make
cpu_name and cpu_rev local to the functions?
That would reduce some churn here.

Also this does not apply to my omap-for-v3.9/soc
branch. Care to update this (and possibly the second one)
against that?

Regards,

Tony
