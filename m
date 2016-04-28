From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Thu, 28 Apr 2016 09:54:09 +0800
Message-ID: <20160428015409.GA12199@shlinux2.ap.freescale.net>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <AM4PR04MB213045DC3D1C1D67A7D9AF0689630@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <20160426034711.GC2978@peterchendt>
 <AM4PR04MB2130124412E09799A2CB01BF89630@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <20160426062809.GD2978@peterchendt>
 <AM4PR04MB2130503C9E7C2B984457A61089630@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <20160426082106.GE2978@peterchendt>
 <20160427031509.GA22637@shlinux2.ap.freescale.net>
 <57209BA0.6040508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57209BA0.6040508-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 27, 2016 at 01:59:44PM +0300, Roger Quadros wrote:
> Hi,
> 
> On 27/04/16 06:15, Peter Chen wrote:
> > On Tue, Apr 26, 2016 at 04:21:07PM +0800, Peter Chen wrote:
> >> On Tue, Apr 26, 2016 at 07:00:22AM +0000, Jun Li wrote:
> >>> Hi
> >>>
> >>>> -----Original Message-----
> >>>> From: Peter Chen [mailto:hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> >>>> Sent: Tuesday, April 26, 2016 2:28 PM
> >>>> To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
> >>>> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>; stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org;
> >>>> balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org;
> >>>> dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org;
> >>>> mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org;
> >>>> abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org; r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> >>>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
> >>>>
> >>>> On Tue, Apr 26, 2016 at 05:11:36AM +0000, Jun Li wrote:
> >>>>> Hi
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Peter Chen [mailto:hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> >>>>>> Sent: Tuesday, April 26, 2016 11:47 AM
> >>>>>> To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
> >>>>>> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>; stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org;
> >>>>>> balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org;
> >>>>>> peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org; dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> >>>>>> jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org; mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> >>>>>> tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org; abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org;
> >>>>>> r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> >>>>>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>>>> Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
> >>>>>>
> >>>>>> On Tue, Apr 26, 2016 at 02:07:56AM +0000, Jun Li wrote:
> >>>>>>>> +struct usb_otg *usb_otg_register(struct device *dev,
> >>>>>>>> +				 struct usb_otg_config *config) {
> >>>>>>>> +	struct usb_otg *otg;
> >>>>>>>> +	struct otg_wait_data *wait;
> >>>>>>>> +	int ret = 0;
> >>>>>>>> +
> >>>>>>>> +	if (!dev || !config || !config->fsm_ops)
> >>>>>>>> +		return ERR_PTR(-EINVAL);
> >>>>>>>> +
> >>>>>>>> +	/* already in list? */
> >>>>>>>> +	mutex_lock(&otg_list_mutex);
> >>>>>>>> +	if (usb_otg_get_data(dev)) {
> >>>>>>>> +		dev_err(dev, "otg: %s: device already in otg list\n",
> >>>>>>>> +			__func__);
> >>>>>>>> +		ret = -EINVAL;
> >>>>>>>> +		goto unlock;
> >>>>>>>> +	}
> >>>>>>>> +
> >>>>>>>> +	/* allocate and add to list */
> >>>>>>>> +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
> >>>>>>>> +	if (!otg) {
> >>>>>>>> +		ret = -ENOMEM;
> >>>>>>>> +		goto unlock;
> >>>>>>>> +	}
> >>>>>>>> +
> >>>>>>>> +	otg->dev = dev;
> >>>>>>>> +	otg->caps = config->otg_caps;
> >>>>>>>> +
> >>>>>>>> +	if ((otg->caps->hnp_support || otg->caps->srp_support ||
> >>>>>>>> +	     otg->caps->adp_support) && !config->otg_work)
> >>>>>>>> +		dev_info(dev, "otg: limiting to dual-role\n");
> >>>>>>>
> >>>>>>> dev_err, this should be an error.
> >>>>>>
> >>>>>> The condition may be wrong, but it is an information to show that
> >>>>>> current OTG is dual-role.
> >>>>>
> >>>>> This should not happen in any correct design, I even doubt if we
> >>>>> should try to continue by "downgrade" it to be duel role, currently
> >>>>> the only example user is dual role, so doing like this can't be tested
> >>>>> by real case, this downgrade is not so easy like we image, at least
> >>>>> for chipidea otg driver, simply replace a queue worker may not work,
> >>>>> as we have much more difference between the 2 configs.
> >>>>>
> >>>>
> >>>> Would you show more why chipidea can't work just replace the work item,
> >>>> and see if anything we still can improve for this framework?
> >>>
> >>> In real OTG, we need enable AVV irq,
> >>
> >> Enable and Handling AVV is platform stuff. In this framework, we are
> >> focus on how otg device manages host and gadget together, and the state
> >> machine when the related otg event occurs.
> >>
> >>> but for duel role, nobody care/handle,
> >>> there are much more resource required for OTG: timers, hnp polling,
> >>> otg test device handling... 
> >>
> >> They are common things for fully OTG fsm, you can move them
> >> to common code (In fact, hnp polling handling is already common code).
> >>
> >>>
> >>> with current design, chipidea driver can support real OTG with its own
> >>> queue worker, or DRD with Roger's drd work item if config is correct.
> >>>
> >>> But improve something to work on a *wrong* config will make it complicated
> >>> and does not make much sense IMO.
> >>>
> >>
> >> What does above "config" you mean?
> >>
> >> If the configure is fully OTG, you can choose different state machine,
> >> eg otg_statemachine, if you find it is hard for chipidea to use this
> >> framework, just list the reason, and see if we can improve.
> >>
> > 
> > Roger, after discussing with Jun off line, we think usb_otg_register
> > should return -ENOTSUPP if platform is OTG capabilities (HNP || SRP ||
> > ADP), since this patch set does not cover fully otg features, the users
> 
> But this series isn't preventing full otg implementation. You can
> still do that via config->otg_work.
> 
> I can modify the following condition to return -ENOTSUPP instead of
> defaulting to dual-role
> 
> struct usb_otg *usb_otg_register(...)
> {
> ...
>         if ((otg->caps->hnp_support || otg->caps->srp_support ||
>              otg->caps->adp_support) && !config->otg_work) {
> 		dev_err(dev, "otg: otg_work must be provided for OTG support\n");
> 		return -ENOTSUPP;
> 	}
> ...
> }
> 

According to Jun, this framework still needs to improve (maybe small) even
using user work item for fully OTG, so the first step is let the drd
work well:)

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
