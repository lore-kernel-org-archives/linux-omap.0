From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 1/2] PM / AVS: SmartReflex: use devm_* API to initialize SmartReflex
Date: Mon, 10 Jun 2013 10:51:13 -0700
Message-ID: <87ppvtdfce.fsf@linaro.org>
References: <1370339913-16135-1-git-send-email-andrii.tseglytskyi@ti.com>
	<1370339913-16135-2-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370339913-16135-2-git-send-email-andrii.tseglytskyi@ti.com>
	(Andrii Tseglytskyi's message of "Tue, 4 Jun 2013 12:58:32 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:

> Use of of devm_* API for resource allocation provides benefits such
> as auto handling of resource free. This reduces possibility have
> memory leaks in case of wrong error handling. All direct release
> calls should be removed to avoid races.
>
> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>

Thanks, queuing this for v3.11.

Kevin
