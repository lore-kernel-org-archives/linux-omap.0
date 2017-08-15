From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Potential error pointer
 dereferences
Date: Tue, 15 Aug 2017 14:26:43 +0800
Message-ID: <1502778403.2591.3.camel@intel.com>
References: <20170710072422.rs25i5oawmiaofrp@mwanda>
         <1502416833.2598.3.camel@intel.com>
         <20170811075510.cnaisfliycev43w4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170811075510.cnaisfliycev43w4@mwanda>
Sender: linux-pm-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2017-08-11 at 10:55 +0300, Dan Carpenter wrote:
> On Fri, Aug 11, 2017 at 10:00:33AM +0800, Zhang Rui wrote:
> > 
> > On Mon, 2017-07-10 at 10:24 +0300, Dan Carpenter wrote:
> > > 
> > > ti_bandgap_get_sensor_data() can return error pointers so we
> > > should
> > > check for that.  There is no need to check "data->ti_thermal" for
> > > NULL
> > > and we removed that from the other cleanup function so we may as
> > > well
> > > from it in ti_thermal_remove_sensor() to be consistent.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > > b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > > index c211a8e4a210..9fea354ca90c 100644
> > > --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > > +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > > @@ -210,7 +210,7 @@ int ti_thermal_remove_sensor(struct
> > > ti_bandgap
> > > *bgp, int id)
> > >  
> > >  	data = ti_bandgap_get_sensor_data(bgp, id);
> > >  
> > > -	if (data && data->ti_thermal) {
> > > +	if (data && !IS_ERR(data)) {
> > what about
> > 	if (!IS_ERR_OR_NULL(data))
> > 
> Duh.  Of course, let me resend.

that's okay, patch has been updated and applied.

>From 474b6dbed714ff5786a0d4ae084717bb75bc7169 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 10 Jul 2017 10:24:23 +0300
Subject: [PATCH] thermal: ti-soc-thermal: Potential error pointer dereferences

ti_bandgap_get_sensor_data() can return error pointers so we should
check for that.  There is no need to check "data->ti_thermal" for NULL
and we removed that from the other cleanup function so we may as well
from it in ti_thermal_remove_sensor() to be consistent.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index c211a8e..92b3207 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -210,7 +210,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data && data->ti_thermal) {
+	if (!IS_ERR_OR_NULL(data)) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
 	}
@@ -276,7 +276,7 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data) {
+	if (!IS_ERR_OR_NULL(data)) {
 		cpufreq_cooling_unregister(data->cool_dev);
 		cpufreq_cpu_put(data->policy);
 	}
-- 
2.7.4
