From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 6/7] omap4: thermal: add basic CPU thermal
 zone
Date: Thu, 28 Jun 2012 08:24:00 +0300
Message-ID: <20120628052400.GG2471@besouro>
References: <4FEB4B57.6030109@dev.rtsoft.ru> <20120628051207.GF2471@besouro>
	<4D68720C2E767A4AA6A8796D42C8EB59149DB0@BGSMSX101.gar.corp.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59149DB0@BGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "kishon@ti.com" <kishon@ti.com>, "balbi@ti.com" <balbi@ti.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello Durga,

On Thu, Jun 28, 2012 at 05:16:43AM +0000, R, Durgadoss wrote:
> Hi,
> 
> > > +
> > > +	data = devm_kzalloc(bg_ptr->dev, sizeof(*data), GFP_KERNEL);
> > > +	if (!data) {
> > > +		dev_err(bg_ptr->dev, "kzalloc fail\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +	data->sensor_id = id;
> > > +	data->bg_ptr = bg_ptr;
> > > +	data->omap4_thermal = thermal_zone_device_register(domain, 0,
> > > +				data, &omap4_thermal_ops, 0, 0, 0, 0);
> 
> Please watch out for changes on this API.
> The third argument is the flag for writeable trip points.
> This patch is in linux-next. So, kindly have a look at this API
> implementation in thermal_sys.c in linux-next, when you submit this patch
> next time.

Ok. Thanks for the heads up. I will have a look on linux-next.

> 
> Thanks,
> Durga
