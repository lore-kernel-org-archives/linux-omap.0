From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] ARM: OMAP2+: PM: Denote the cpuidle tracepoints as _rcuidle()
Date: Wed, 23 Sep 2015 10:59:04 -0700
Message-ID: <7hfv25dnkn.fsf@deeprootsystems.com>
References: <1442554881-706-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442554881-706-1-git-send-email-jszhang@marvell.com> (Jisheng
	Zhang's message of "Fri, 18 Sep 2015 13:41:21 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Jisheng Zhang <jszhang@marvell.com> writes:

> The cpuidle tracepoints are called within a rcu_idle_exit() section, and
> must be denoted with the _rcuidle() version of the tracepoint.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
 
Acked-by: Kevin Hilman <khilman@linaro.org>
