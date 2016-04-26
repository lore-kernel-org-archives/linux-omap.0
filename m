From: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Tue, 26 Apr 2016 05:11:36 +0000
Message-ID: <AM4PR04MB2130124412E09799A2CB01BF89630@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <AM4PR04MB213045DC3D1C1D67A7D9AF0689630@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <20160426034711.GC2978@peterchendt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160426034711.GC2978@peterchendt>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

> -----Original Message-----
> From: Peter Chen [mailto:hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Tuesday, April 26, 2016 11:47 AM
> To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>; stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org;
> balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org;
> dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org;
> mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org;
> abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org; r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
> 
> On Tue, Apr 26, 2016 at 02:07:56AM +0000, Jun Li wrote:
> > > +struct usb_otg *usb_otg_register(struct device *dev,
> > > +				 struct usb_otg_config *config) {
> > > +	struct usb_otg *otg;
> > > +	struct otg_wait_data *wait;
> > > +	int ret = 0;
> > > +
> > > +	if (!dev || !config || !config->fsm_ops)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	/* already in list? */
> > > +	mutex_lock(&otg_list_mutex);
> > > +	if (usb_otg_get_data(dev)) {
> > > +		dev_err(dev, "otg: %s: device already in otg list\n",
> > > +			__func__);
> > > +		ret = -EINVAL;
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	/* allocate and add to list */
> > > +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
> > > +	if (!otg) {
> > > +		ret = -ENOMEM;
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	otg->dev = dev;
> > > +	otg->caps = config->otg_caps;
> > > +
> > > +	if ((otg->caps->hnp_support || otg->caps->srp_support ||
> > > +	     otg->caps->adp_support) && !config->otg_work)
> > > +		dev_info(dev, "otg: limiting to dual-role\n");
> >
> > dev_err, this should be an error.
> 
> The condition may be wrong, but it is an information to show that current
> OTG is dual-role.

This should not happen in any correct design, I even doubt if we
should try to continue by "downgrade" it to be duel role, currently
the only example user is dual role, so doing like this can't be
tested by real case, this downgrade is not so easy like we image,
at least for chipidea otg driver, simply replace a queue worker may
not work, as we have much more difference between the 2 configs.

Li Jun
 
> 
> Peter
> >
> > > +
> > > +	if (config->otg_work)	/* custom otg_work ? */
> > > +		INIT_WORK(&otg->work, config->otg_work);
> > > +	else
> > > +		INIT_WORK(&otg->work, usb_otg_work);
> > > +
> > > +	otg->wq = create_singlethread_workqueue("usb_otg");
> > > +	if (!otg->wq) {
> > > +		dev_err(dev, "otg: %s: can't create workqueue\n",
> > > +			__func__);
> > > +		ret = -ENOMEM;
> > > +		goto err_wq;
> > > +	}
> > > +
> > > +	/* set otg ops */
> > > +	otg->fsm.ops = config->fsm_ops;
> > > +
> > > +	mutex_init(&otg->fsm.lock);
> > > +
> > > +	list_add_tail(&otg->list, &otg_list);
> > > +	mutex_unlock(&otg_list_mutex);
> > > +
> > > +	/* were we in wait list? */
> > > +	mutex_lock(&wait_list_mutex);
> > > +	wait = usb_otg_get_wait(dev);
> > > +	mutex_unlock(&wait_list_mutex);
> > > +	if (wait) {
> > > +		/* register pending host/gadget and flush from list */
> > > +		usb_otg_flush_wait(dev);
> > > +	}
> > > +
> > > +	return otg;
> > > +
> > > +err_wq:
> > > +	kfree(otg);
> > > +unlock:
> > > +	mutex_unlock(&otg_list_mutex);
> > > +	return ERR_PTR(ret);
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_otg_register);
> > > +
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb"
> > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> Best Regards,
> Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
