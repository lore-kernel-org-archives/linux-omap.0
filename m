From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] perf: add calls to suspend trace point
Date: Tue, 4 Jan 2011 11:39:43 +0100
Message-ID: <20110104103943.GA2447@elte.hu>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
 <1294136263-24020-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1294136263-24020-2-git-send-email-j-pihet@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-kernel@vger.kernel.org, trenn@suse.de, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org


* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> Uses the machine_suspend trace point, called from the
> generic kernel suspend_enter function.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> CC: Thomas Renninger <trenn@suse.de>
> ---
>  kernel/power/suspend.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Please use the scripts/get_maintainer.pl to construct a proper Cc: list and to 
gather the necessary Acked-by:

  scripts/get_maintainer.pl -f kernel/power/suspend.c

Thanks,

	Ingo
