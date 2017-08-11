From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Potential error pointer
 dereferences
Date: Fri, 11 Aug 2017 10:55:42 +0300
Message-ID: <20170811075510.cnaisfliycev43w4@mwanda>
References: <20170710072422.rs25i5oawmiaofrp@mwanda>
 <1502416833.2598.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502416833.2598.3.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 11, 2017 at 10:00:33AM +0800, Zhang Rui wrote:
> On Mon, 2017-07-10 at 10:24 +0300, Dan Carpenter wrote:
> > ti_bandgap_get_sensor_data() can return error pointers so we should
> > check for that.  There is no need to check "data->ti_thermal" for
> > NULL
> > and we removed that from the other cleanup function so we may as well
> > from it in ti_thermal_remove_sensor() to be consistent.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > index c211a8e4a210..9fea354ca90c 100644
> > --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > @@ -210,7 +210,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap
> > *bgp, int id)
> >  
> >  	data = ti_bandgap_get_sensor_data(bgp, id);
> >  
> > -	if (data && data->ti_thermal) {
> > +	if (data && !IS_ERR(data)) {
> 
> what about
> 	if (!IS_ERR_OR_NULL(data))
> 

Duh.  Of course, let me resend.

regards,
dan carpenter
