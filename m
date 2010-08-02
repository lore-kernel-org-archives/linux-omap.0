From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC 3/7] OMAP: Introduce voltage domain pointer and device specific
 set rate and get rate in device opp structures.
Date: Mon, 02 Aug 2010 14:10:45 +0200
Message-ID: <4C56B5C5.2070504@ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com> <1278065909-32148-2-git-send-email-thara@ti.com> <1278065909-32148-3-git-send-email-thara@ti.com> <1278065909-32148-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39525 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab0HBMKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 08:10:52 -0400
In-Reply-To: <1278065909-32148-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hi Thara,

On 7/2/2010 12:18 PM, Gopinath, Thara wrote:
> This patch extends the device opp structure to contain
> info about the voltage domain to which the device belongs to
> and to contain pointers to scale the operating rate of the
> device. This patch also adds an API in the opp layer that
> can be used by the voltage layer to get a list of all the
> scalable devices belonging to a particular voltage domain.
> This API is to be typically called only once by the voltage
> layer per voltage domain instance and the device list should
> be stored. This approach makes it easy during dvfs to scale
> all the devices associated with a voltage domain and then
> scale the voltage domain.
>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> ---
>   arch/arm/plat-omap/include/plat/opp.h |   37 +++++++++++++++++++++++++-
>   arch/arm/plat-omap/opp.c              |   47 +++++++++++++++++++++++++-------
>   2 files changed, 72 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> index 893731f..15e1e70 100644
> --- a/arch/arm/plat-omap/include/plat/opp.h
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -16,6 +16,7 @@
>
>   #include<linux/err.h>
>   #include<linux/cpufreq.h>
> +#include<linux/clk.h>
>
>   #include<plat/common.h>
>
> @@ -38,21 +39,45 @@
>    */
>   struct omap_opp_def {
>   	char *hwmod_name;
> +	char *vdd_name;

vdd should be an attribute of hwmod. For one hwmod in a soc we will 
always have the same vdd.
That will avoid to duplicate information and to have to populate that in 
each OPP entry (cf patch 6).

>
>   	unsigned long freq;
>   	unsigned long u_volt;
>
> +	int (*set_rate)(struct device *dev, unsigned long rate);
> +	unsigned long (*get_rate) (struct device *dev);

We might already discussed that, but why should we store that per OPP?
Cannot we store that per device?

Regards,
Benoit
