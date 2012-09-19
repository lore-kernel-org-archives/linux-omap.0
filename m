From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: OMAP: Check IS_ERR() instead of NULL for omap_device_get_by_hwmod_name
Date: Wed, 19 Sep 2012 22:17:42 +0200
Message-ID: <201209192217.42157.rjw@sisk.pl>
References: <1347932747.6562.3.camel@phoenix> <201209182052.57414.rjw@sisk.pl> <877grqj6qw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <877grqj6qw.fsf@deeprootsystems.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, September 19, 2012, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Tuesday, September 18, 2012, Axel Lin wrote:
> >> omap_device_get_by_hwmod_name() returns ERR_PTR on error.
> >> 
> >> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> >
> > Kevin, should I take this?
> 
> Yes, please.
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Done.

Thanks,
Rafael
