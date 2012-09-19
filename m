From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] cpufreq: OMAP: Check IS_ERR() instead of NULL for omap_device_get_by_hwmod_name
Date: Wed, 19 Sep 2012 09:51:35 -0700
Message-ID: <877grqj6qw.fsf@deeprootsystems.com>
References: <1347932747.6562.3.camel@phoenix> <201209182052.57414.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201209182052.57414.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 18 Sep 2012 20:52:57 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, September 18, 2012, Axel Lin wrote:
>> omap_device_get_by_hwmod_name() returns ERR_PTR on error.
>> 
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> Kevin, should I take this?

Yes, please.

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks,

Kevin
