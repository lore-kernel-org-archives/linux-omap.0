From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V5 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Tue, 21 Aug 2012 16:36:22 +0530
Message-ID: <CAF0AtAtvyKdW-J97NJ+YNi5pUGQFyxk=B2Eqn_74MZD4dWebEA@mail.gmail.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
	<cover.1345468541.git.cmahapatra@ti.com>
	<94a123bbc0a4ecd48fc71275fd5efbe0aac93b87.1345468541.git.cmahapatra@ti.com>
	<1345545312.4085.46.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:35494 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756817Ab2HULGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 07:06:31 -0400
Received: by vbme21 with SMTP id e21so8069135vbm.35
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 04:06:22 -0700 (PDT)
In-Reply-To: <1345545312.4085.46.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Aug 21, 2012 at 4:05 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-08-20 at 18:53 +0530, Chandrabhanu Mahapatra wrote:
>> All the cpu_is checks have been moved to dss_init_features function providing a
>> much more generic and cleaner interface. The OMAP version and revision specific
>> initializations in various functions are cleaned and the necessary data are
>> moved to dss_features structure which is local to dss.c.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dss.c |  117 ++++++++++++++++++++++++++---------------
>>  1 file changed, 76 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 10566ae..f6d3d0a 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/gfp.h>
>>
>>  #include <video/omapdss.h>
>>
>> @@ -65,6 +66,12 @@ struct dss_reg {
>>  static int dss_runtime_get(void);
>>  static void dss_runtime_put(void);
>>
>> +struct dss_features {
>> +     u16 fck_div_max;
>> +     int dss_fck_multiplier;
>> +     char *clk_name;
>
> const char *
>
>  Tomi
>

All the values are const. So we have a const pointer dss.feat to hold
this structure. Is a separate
const char *clk_name required?

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
