From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Mon, 20 Jun 2016 10:45:31 +0300
Message-ID: <87h9coxq04.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <575E672E.5070603-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> It provides APIs for the following tasks
>
> - Registering an OTG/dual-role capable controller
> - Registering Host and Gadget controllers to OTG core
> - Providing inputs to and kicking the OTG state machine

I think I have already mentioned this, but after over 10 years of OTG,
nobody seems to care about it, why are we still touching at all I don't
know. For common non-OTG role-swapping we really don't need any of this
and, quite frankly, I fail to see enough users for this.

Apparently there's only chipidea which, AFAICT, already had working
dual-role before this OTG State Machine was added to the kernel.

> Provide a dual-role device (DRD) state machine.

there's not such thing as DRD state machine. You don't need to go
through all these states, actually.

> DRD mode is a reduced functionality OTG mode. In this mode
> we don't support SRP, HNP and dynamic role-swap.
>
> In DRD operation, the controller mode (Host or Peripheral)
> is decided based on the ID pin status. Once a cable plug (Type-A
> or Type-B) is attached the controller selects the state
> and doesn't change till the cable in unplugged and a different
> cable type is inserted.
>
> As we don't need most of the complex OTG states and OTG timers
> we implement a lean DRD state machine in usb-otg.c.
> The DRD state machine is only interested in 2 hardware inputs
> 'id' and 'b_sess_vld'.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
> v11:
> - remove usb_otg_kick_fsm().
> - typo fixes: structa/structure, upto/up to.
> - remove "obj-$(CONFIG_USB_OTG_CORE)     +=3D common/" from Makefile.
>
>  drivers/usb/Kconfig          |  18 +
>  drivers/usb/common/Makefile  |   6 +-
>  drivers/usb/common/usb-otg.c | 877 +++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/usb/core/Kconfig     |  14 -
>  drivers/usb/gadget/Kconfig   |   1 +
>  include/linux/usb/gadget.h   |   2 +
>  include/linux/usb/hcd.h      |   1 +
>  include/linux/usb/otg-fsm.h  |   7 +
>  include/linux/usb/otg.h      | 174 ++++++++-
>  9 files changed, 1070 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/usb/common/usb-otg.c
>
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 8689dcb..ed596ec 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -32,6 +32,23 @@ if USB_SUPPORT
>  config USB_COMMON
>  	tristate
>=20=20
> +config USB_OTG_CORE
> +	tristate

why tristate if you can never set it to 'M'?

> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> new file mode 100644
> index 0000000..a23ab1e
> --- /dev/null
> +++ b/drivers/usb/common/usb-otg.c
> @@ -0,0 +1,877 @@
> +/**
> + * drivers/usb/common/usb-otg.c - USB OTG core
> + *
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com
> + * Author: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/workqueue.h>
> +
> +/* OTG device list */
> +LIST_HEAD(otg_list);

not static? Who needs to touch this private list?

> +static DEFINE_MUTEX(otg_list_mutex);
> +
> +static int usb_otg_hcd_is_primary_hcd(struct usb_hcd *hcd)
> +{
> +	if (!hcd->primary_hcd)
> +		return 1;

these seems inverted. If hcd->primary is NULL (meaning, there's no
=2D>primary_hcd), then we tell caller that this _is_ a primary hcd? Care
to explain?

> +	return hcd =3D=3D hcd->primary_hcd;
> +}
> +
> +/**
> + * usb_otg_get_data() - get usb_otg data structure
> + * @otg_dev:	OTG controller device
> + *
> + * Check if the OTG device is in our OTG list and return
> + * usb_otg data, else NULL.
> + *
> + * otg_list_mutex must be held.
> + *
> + * Return: usb_otg data on success, NULL otherwise.
> + */
> +static struct usb_otg *usb_otg_get_data(struct device *otg_dev)
> +{
> +	struct usb_otg *otg;
> +
> +	if (!otg_dev)
> +		return NULL;
> +
> +	list_for_each_entry(otg, &otg_list, list) {
> +		if (otg->dev =3D=3D otg_dev)
> +			return otg;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * usb_otg_start_host() - start/stop the host controller
> + * @otg:	usb_otg instance
> + * @on:		true to start, false to stop
> + *
> + * Start/stop the USB host controller. This function is meant
> + * for use by the OTG controller driver.
> + *
> + * Return: 0 on success, error value otherwise.
> + */
> +int usb_otg_start_host(struct usb_otg *otg, int on)
> +{
> +	struct otg_hcd_ops *hcd_ops =3D otg->hcd_ops;
> +	int ret;
> +
> +	dev_dbg(otg->dev, "otg: %s %d\n", __func__, on);
> +	if (!otg->host) {
> +		WARN_ONCE(1, "otg: fsm running without host\n");

if (WARN_ONCE(!otg->host, "otg: fsm running without host\n"))
	return 0;

but, frankly, if you require a 'host' and a 'gadget' don't start this
layer until you have both.

> +		return 0;
> +	}
> +
> +	if (on) {
> +		if (otg->flags & OTG_FLAG_HOST_RUNNING)
> +			return 0;
> +
> +		/* start host */
> +		ret =3D hcd_ops->add(otg->primary_hcd.hcd,
> +				   otg->primary_hcd.irqnum,
> +				   otg->primary_hcd.irqflags);

this is usb_add_hcd(), is it not? Why add an indirection?

> +		if (ret) {
> +			dev_err(otg->dev, "otg: host add failed %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (otg->shared_hcd.hcd) {
> +			ret =3D hcd_ops->add(otg->shared_hcd.hcd,
> +					   otg->shared_hcd.irqnum,
> +					   otg->shared_hcd.irqflags);
> +			if (ret) {
> +				dev_err(otg->dev, "otg: shared host add failed %d\n",
> +					ret);
> +				hcd_ops->remove(otg->primary_hcd.hcd);
> +				return ret;
> +			}
> +		}
> +		otg->flags |=3D OTG_FLAG_HOST_RUNNING;
> +	} else {
> +		if (!(otg->flags & OTG_FLAG_HOST_RUNNING))
> +			return 0;
> +
> +		otg->flags &=3D ~OTG_FLAG_HOST_RUNNING;
> +
> +		/* stop host */
> +		if (otg->shared_hcd.hcd)
> +			hcd_ops->remove(otg->shared_hcd.hcd);

usb_del_hcd()?

> +		hcd_ops->remove(otg->primary_hcd.hcd);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_start_host);
> +
> +/**
> + * usb_otg_start_gadget() - start/stop the gadget controller
> + * @otg:	usb_otg instance
> + * @on:		true to start, false to stop
> + *
> + * Start/stop the USB gadget controller. This function is meant
> + * for use by the OTG controller driver.
> + *
> + * Return: 0 on success, error value otherwise.
> + */
> +int usb_otg_start_gadget(struct usb_otg *otg, int on)
> +{
> +	struct usb_gadget *gadget =3D otg->gadget;
> +	int ret;
> +
> +	dev_dbg(otg->dev, "otg: %s %d\n", __func__, on);
> +	if (!gadget) {
> +		WARN_ONCE(1, "otg: fsm running without gadget\n");
> +		return 0;
> +	}

ditto

> +	if (on) {
> +		if (otg->flags & OTG_FLAG_GADGET_RUNNING)
> +			return 0;
> +
> +		ret =3D otg->gadget_ops->start(otg->gadget);
> +		if (ret) {
> +			dev_err(otg->dev, "otg: gadget start failed: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		otg->flags |=3D OTG_FLAG_GADGET_RUNNING;
> +	} else {
> +		if (!(otg->flags & OTG_FLAG_GADGET_RUNNING))
> +			return 0;
> +
> +		ret =3D otg->gadget_ops->stop(otg->gadget);
> +		if (ret) {
> +			dev_err(otg->dev, "otg: gadget stop failed: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		otg->flags &=3D ~OTG_FLAG_GADGET_RUNNING;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_start_gadget);
> +
> +/**
> + * drd_set_protocol() -  Set USB protocol if possible
> + * @fsm:	DRD FSM instance
> + * @protocol:	USB protocol to set the state machine to
> + *
> + * Sets the OTG FSM protocol to @protocol if it changed.
> + * fsm->lock must be held.
> + *
> + * Return: 0 on success, error value otherwise.
> + */
> +static int drd_set_protocol(struct otg_fsm *fsm, int protocol)
> +{
> +	struct usb_otg *otg =3D container_of(fsm, struct usb_otg, fsm);
> +	int ret =3D 0;
> +
> +	if (fsm->protocol !=3D protocol) {
> +		dev_dbg(otg->dev, "otg: changing role fsm->protocol=3D %d; new protoco=
l=3D %d\n",
> +			fsm->protocol, protocol);
> +		/* stop old protocol */
> +		if (fsm->protocol =3D=3D PROTO_HOST) {
> +			ret =3D otg_start_host(otg, 0);
> +		} else if (fsm->protocol =3D=3D PROTO_GADGET) {
> +			otg->gadget_ops->connect_control(otg->gadget, false);
> +			ret =3D otg_start_gadget(otg, 0);
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		/* start new protocol */
> +		if (protocol =3D=3D PROTO_HOST) {
> +			ret =3D otg_start_host(otg, 1);
> +		} else if (protocol =3D=3D PROTO_GADGET) {
> +			ret =3D otg_start_gadget(otg, 1);
> +			otg->gadget_ops->connect_control(otg->gadget, true);
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		fsm->protocol =3D protocol;
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * drd_set_state() - Set the DRD state machine state.
> + * @fsm:	DRD FSM instance
> + * @new_state:	the new state the DRD FSM must be set to
> + *
> + * Sets the state of the DRD state machine.
> + * fsm->lock must be held.
> + */
> +static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_st=
ate)
> +{
> +	struct usb_otg *otg =3D container_of(fsm, struct usb_otg, fsm);
> +
> +	if (otg->state =3D=3D new_state)
> +		return;
> +
> +	fsm->state_changed =3D 1;
> +	dev_dbg(otg->dev, "otg: set state: %s\n",
> +		usb_otg_state_string(new_state));
> +	switch (new_state) {
> +	case OTG_STATE_B_IDLE:
> +		drd_set_protocol(fsm, PROTO_UNDEF);
> +		otg_drv_vbus(otg, 0);
> +		break;
> +	case OTG_STATE_B_PERIPHERAL:
> +		drd_set_protocol(fsm, PROTO_GADGET);
> +		otg_drv_vbus(otg, 0);
> +		break;
> +	case OTG_STATE_A_HOST:
> +		drd_set_protocol(fsm, PROTO_HOST);
> +		otg_drv_vbus(otg, 1);
> +		break;
> +	default:
> +		dev_warn(otg->dev, "%s: otg: invalid state: %s\n",
> +			 __func__, usb_otg_state_string(new_state));
> +		break;
> +	}
> +
> +	otg->state =3D new_state;
> +}
> +
> +/**
> + * drd_statemachine() - DRD state change judgement
> + * @otg:	usb_otg instance
> + *
> + * Checks the state machine inputs and state and makes a state change
> + * if required.
> + *
> + * For DRD we're only interested in some of the OTG states
> + * i.e. OTG_STATE_B_IDLE: both peripheral and host are stopped
> + *	OTG_STATE_B_PERIPHERAL: peripheral active
> + *	OTG_STATE_A_HOST: host active
> + * we're only interested in the following inputs
> + *	fsm->id, fsm->b_sess_vld
> + *
> + * Return: 0 if state wasn't changed, 1 if state changed.
> + */
> +int drd_statemachine(struct usb_otg *otg)
> +{
> +	struct otg_fsm *fsm =3D &otg->fsm;
> +	enum usb_otg_state state;
> +	int ret;
> +
> +	mutex_lock(&fsm->lock);
> +
> +	fsm->state_changed =3D 0;
> +	state =3D otg->state;
> +
> +	switch (state) {
> +	case OTG_STATE_UNDEFINED:
> +		if (!fsm->id)
> +			drd_set_state(fsm, OTG_STATE_A_HOST);
> +		else if (fsm->id && fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
> +		else
> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
> +		break;
> +	case OTG_STATE_B_IDLE:
> +		if (!fsm->id)
> +			drd_set_state(fsm, OTG_STATE_A_HOST);
> +		else if (fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
> +		break;
> +	case OTG_STATE_B_PERIPHERAL:
> +		if (!fsm->id)
> +			drd_set_state(fsm, OTG_STATE_A_HOST);
> +		else if (!fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
> +		break;
> +	case OTG_STATE_A_HOST:
> +		if (fsm->id && fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
> +		else if (fsm->id && !fsm->b_sess_vld)
> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
> +		break;
> +
> +	default:
> +		dev_err(otg->dev, "%s: otg: invalid usb-drd state: %s\n",
> +			__func__, usb_otg_state_string(state));
> +		break;
> +	}
> +
> +	ret =3D fsm->state_changed;
> +	mutex_unlock(&fsm->lock);
> +	dev_dbg(otg->dev, "otg: quit statemachine, changed %d\n",
> +		fsm->state_changed);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(drd_statemachine);

why is this exported at all? It only runs from the work_struct
below. BTW, that work_struct looks unnecessary.

> +
> +/**
> + * usb_drd_work() - Dual-role state machine work function
> + * @work: work_struct context
> + *
> + * Runs the DRD state machine. Scheduled whenever there is a change
> + * in FSM inputs.
> + */
> +static void usb_drd_work(struct work_struct *work)
> +{
> +	struct usb_otg *otg =3D container_of(work, struct usb_otg, work);
> +
> +	pm_runtime_get_sync(otg->dev);
> +	while (drd_statemachine(otg))
> +		;
> +	pm_runtime_put_sync(otg->dev);

so, once this gets kicked it'll keep on running until a state doesn't
change.

> +}
> +
> +/**
> + * usb_otg_register() - Register the OTG/dual-role device to OTG core
> + * @dev: OTG/dual-role controller device.
> + * @config: OTG configuration.
> + *
> + * Registers the OTG/dual-role controller device with the USB OTG core.
> + *
> + * Return: struct usb_otg * if success, ERR_PTR() otherwise.
> + */
> +struct usb_otg *usb_otg_register(struct device *dev,
> +				 struct usb_otg_config *config)
> +{
> +	struct usb_otg *otg;
> +	int ret =3D 0;
> +
> +	if (!dev || !config || !config->fsm_ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* already in list? */
> +	mutex_lock(&otg_list_mutex);
> +	if (usb_otg_get_data(dev)) {
> +		dev_err(dev, "otg: %s: device already in otg list\n",
> +			__func__);
> +		ret =3D -EINVAL;
> +		goto unlock;
> +	}
> +
> +	/* allocate and add to list */
> +	otg =3D kzalloc(sizeof(*otg), GFP_KERNEL);
> +	if (!otg) {
> +		ret =3D -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	otg->dev =3D dev;
> +	/* otg->caps is controller caps + DT overrides */
> +	otg->caps =3D *config->otg_caps;
> +	ret =3D of_usb_update_otg_caps(dev->of_node, &otg->caps);
> +	if (ret)
> +		goto err_wq;
> +
> +	if ((otg->caps.hnp_support || otg->caps.srp_support ||
> +	     otg->caps.adp_support) && !config->otg_work) {
> +		dev_err(dev,
> +			"otg: otg_work must be provided for OTG support\n");
> +		ret =3D -EINVAL;
> +		goto err_wq;
> +	}
> +
> +	if (config->otg_work)	/* custom otg_work ? */
> +		INIT_WORK(&otg->work, config->otg_work);
> +	else
> +		INIT_WORK(&otg->work, usb_drd_work);

why do you need to cope with custom work handlers?

> +	otg->wq =3D create_freezable_workqueue("usb_otg");
> +	if (!otg->wq) {
> +		dev_err(dev, "otg: %s: can't create workqueue\n",
> +			__func__);
> +		ret =3D -ENOMEM;
> +		goto err_wq;
> +	}
> +
> +	/* set otg ops */
> +	otg->fsm.ops =3D config->fsm_ops;
> +
> +	mutex_init(&otg->fsm.lock);
> +
> +	list_add_tail(&otg->list, &otg_list);
> +	mutex_unlock(&otg_list_mutex);
> +
> +	return otg;
> +
> +err_wq:
> +	kfree(otg);
> +unlock:
> +	mutex_unlock(&otg_list_mutex);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_register);
> +
> +/**
> + * usb_otg_unregister() - Unregister the OTG/dual-role device from USB O=
TG core
> + * @dev: OTG controller device.
> + *
> + * Unregisters the OTG/dual-role controller device from USB OTG core.
> + * Prevents unregistering till both the associated Host and Gadget contr=
ollers
> + * have unregistered from the OTG core.
> + *
> + * Return: 0 on success, error value otherwise.
> + */
> +int usb_otg_unregister(struct device *dev)
> +{
> +	struct usb_otg *otg;
> +
> +	mutex_lock(&otg_list_mutex);
> +	otg =3D usb_otg_get_data(dev);
> +	if (!otg) {
> +		dev_err(dev, "otg: %s: device not in otg list\n",
> +			__func__);
> +		mutex_unlock(&otg_list_mutex);
> +		return -EINVAL;
> +	}
> +
> +	/* prevent unregister till both host & gadget have unregistered */
> +	if (otg->host || otg->gadget) {
> +		dev_err(dev, "otg: %s: host/gadget still registered\n",
> +			__func__);
> +		mutex_unlock(&otg_list_mutex);
> +		return -EBUSY;
> +	}

I think a better choice would've been to unregister host and gadget in
case they haven't been unregistered yet. That's a common
expectation. Specially since driver core does the same thing when you
unregister a parent device.

> +	/* OTG FSM is halted when host/gadget unregistered */
> +	destroy_workqueue(otg->wq);
> +
> +	/* remove from otg list */
> +	list_del(&otg->list);
> +	kfree(otg);
> +	mutex_unlock(&otg_list_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_unregister);
> +
> +/**
> + * usb_otg_start_fsm() - Start the OTG FSM
> + * @otg:	usb_otg instance
> + *
> + * Start the OTG FSM if we can. The HCD, UDC and gadget function driver
> + * must be ready for the OTG FSM to start.
> + *
> + * fsm->lock must be held.
> + */
> +static void usb_otg_start_fsm(struct usb_otg *otg)
> +{
> +	struct otg_fsm *fsm =3D &otg->fsm;
> +
> +	if (fsm->running)
> +		goto kick_fsm;
> +
> +	if (!otg->host) {
> +		dev_info(otg->dev, "otg: can't start till host registers\n");
> +		return;
> +	}
> +
> +	if (!otg->gadget) {
> +		dev_info(otg->dev,
> +			 "otg: can't start till gadget UDC registers\n");
> +		return;
> +	}

okay, so you never kick the FSM until host and gadget are
registered. Why do you need to test for the case where the FSM is
running without host/gadget?

You seem to guarantee that will never be the case.

> +	if (!otg->gadget_ready) {
> +		dev_info(otg->dev,
> +			 "otg: can't start till gadget function registers\n");
> +		return;
> +	}
> +
> +	fsm->running =3D true;
> +kick_fsm:
> +	queue_work(otg->wq, &otg->work);
> +}
> +
> +/**
> + * usb_otg_stop_fsm() - Stop the OTG FSM
> + * @otg:	usb_otg instance
> + *
> + * Stops the HCD, UDC and the OTG FSM.
> + *
> + * fsm->lock must be held.
> + */
> +static void usb_otg_stop_fsm(struct usb_otg *otg)
> +{
> +	struct otg_fsm *fsm =3D &otg->fsm;
> +
> +	if (!fsm->running)
> +		return;
> +
> +	/* no more new events queued */
> +	fsm->running =3D false;
> +
> +	flush_workqueue(otg->wq);
> +	otg->state =3D OTG_STATE_UNDEFINED;
> +
> +	/* stop host/gadget immediately */
> +	if (fsm->protocol =3D=3D PROTO_HOST) {
> +		otg_start_host(otg, 0);
> +	} else if (fsm->protocol =3D=3D PROTO_GADGET) {
> +		otg->gadget_ops->connect_control(otg->gadget, false);
> +		otg_start_gadget(otg, 0);
> +	}
> +	fsm->protocol =3D PROTO_UNDEF;
> +}
> +
> +/**
> + * usb_otg_sync_inputs() - Sync OTG inputs with the OTG state machine
> + * @otg:	usb_otg instance
> + *
> + * Used by the OTG driver to update the inputs to the OTG
> + * state machine.
> + *
> + * Can be called in IRQ context.
> + */
> +void usb_otg_sync_inputs(struct usb_otg *otg)
> +{
> +	/* Don't kick FSM till it has started */
> +	if (!otg->fsm.running)
> +		return;
> +
> +	/* Kick FSM */
> +	queue_work(otg->wq, &otg->work);
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_sync_inputs);
> +
> +/**
> + * usb_otg_register_hcd() - Register the host controller to OTG core
> + * @hcd:	host controller
> + * @irqnum:	interrupt number
> + * @irqflags:	interrupt flags
> + * @ops:	HCD ops to interface with the HCD
> + *
> + * This is used by the USB Host stack to register the host controller
> + * to the OTG core. Host controller must not be started by the
> + * caller as it is left up to the OTG state machine to do so.
> + * hcd->otg_dev must contain the related otg controller device.
> + *
> + * Return: 0 on success, error value otherwise.
> + */
> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
> +{
> +	struct usb_otg *otg;
> +	struct device *hcd_dev =3D hcd->self.controller;
> +	struct device *otg_dev =3D hcd->otg_dev;
> +
> +	if (!otg_dev)
> +		return -EINVAL;
> +
> +	/* we're otg but otg controller might not yet be registered */
> +	mutex_lock(&otg_list_mutex);
> +	otg =3D usb_otg_get_data(otg_dev);
> +	mutex_unlock(&otg_list_mutex);
> +	if (!otg) {
> +		dev_dbg(hcd_dev,
> +			"otg: controller not yet registered. deferring.\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	/* HCD will be started by OTG fsm when needed */
> +	mutex_lock(&otg->fsm.lock);
> +	if (otg->primary_hcd.hcd) {
> +		/* probably a shared HCD ? */
> +		if (usb_otg_hcd_is_primary_hcd(hcd)) {
> +			dev_err(otg_dev, "otg: primary host already registered\n");
> +			goto err;
> +		}
> +
> +		if (hcd->shared_hcd =3D=3D otg->primary_hcd.hcd) {
> +			if (otg->shared_hcd.hcd) {
> +				dev_err(otg_dev, "otg: shared host already registered\n");
> +				goto err;
> +			}
> +
> +			otg->shared_hcd.hcd =3D hcd;
> +			otg->shared_hcd.irqnum =3D irqnum;
> +			otg->shared_hcd.irqflags =3D irqflags;
> +			otg->shared_hcd.ops =3D ops;
> +			dev_info(otg_dev, "otg: shared host %s registered\n",
> +				 dev_name(hcd->self.controller));
> +		} else {
> +			dev_err(otg_dev, "otg: invalid shared host %s\n",
> +				dev_name(hcd->self.controller));
> +			goto err;
> +		}
> +	} else {
> +		if (!usb_otg_hcd_is_primary_hcd(hcd)) {
> +			dev_err(otg_dev, "otg: primary host must be registered first\n");
> +			goto err;
> +		}
> +
> +		otg->primary_hcd.hcd =3D hcd;
> +		otg->primary_hcd.irqnum =3D irqnum;
> +		otg->primary_hcd.irqflags =3D irqflags;
> +		otg->primary_hcd.ops =3D ops;
> +		otg->hcd_ops =3D ops;
> +		dev_info(otg_dev, "otg: primary host %s registered\n",
> +			 dev_name(hcd->self.controller));
> +	}
> +
> +	/*
> +	 * we're ready only if we have shared HCD
> +	 * or we don't need shared HCD.
> +	 */
> +	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
> +		otg->host =3D hcd_to_bus(hcd);
> +		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
> +
> +		/* start FSM */
> +		usb_otg_start_fsm(otg);
> +	} else {
> +		dev_dbg(otg_dev, "otg: can't start till shared host registers\n");
> +	}
> +
> +	mutex_unlock(&otg->fsm.lock);
> +
> +	return 0;
> +
> +err:
> +	mutex_unlock(&otg->fsm.lock);
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_register_hcd);
> +
> +/**
> + * usb_otg_unregister_hcd() - Unregister the host controller from OTG co=
re
> + * @hcd:	host controller device
> + *
> + * This is used by the USB Host stack to unregister the host controller
> + * from the OTG core. Ensures that host controller is not running
> + * on successful return.
> + *
> + * Returns: 0 on success, error value otherwise.
> + */
> +int usb_otg_unregister_hcd(struct usb_hcd *hcd)
> +{
> +	struct usb_otg *otg;
> +	struct device *hcd_dev =3D hcd_to_bus(hcd)->controller;
> +	struct device *otg_dev =3D hcd->otg_dev;
> +
> +	if (!otg_dev)
> +		return -EINVAL;	/* we're definitely not OTG */
> +
> +	mutex_lock(&otg_list_mutex);
> +	otg =3D usb_otg_get_data(otg_dev);
> +	mutex_unlock(&otg_list_mutex);
> +	if (!otg) {
> +		dev_err(hcd_dev, "otg: host %s wasn't registered with otg\n",
> +			dev_name(hcd_dev));
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&otg->fsm.lock);
> +	if (hcd =3D=3D otg->primary_hcd.hcd) {
> +		otg->primary_hcd.hcd =3D NULL;
> +		dev_info(otg_dev, "otg: primary host %s unregistered\n",
> +			 dev_name(hcd_dev));
> +	} else if (hcd =3D=3D otg->shared_hcd.hcd) {
> +		otg->shared_hcd.hcd =3D NULL;
> +		dev_info(otg_dev, "otg: shared host %s unregistered\n",
> +			 dev_name(hcd_dev));
> +	} else {
> +		mutex_unlock(&otg->fsm.lock);
> +		dev_err(otg_dev, "otg: host %s wasn't registered with otg\n",
> +			dev_name(hcd_dev));
> +		return -EINVAL;
> +	}
> +
> +	/* stop FSM & Host */
> +	usb_otg_stop_fsm(otg);
> +	otg->host =3D NULL;
> +
> +	mutex_unlock(&otg->fsm.lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_unregister_hcd);
> +
> +/**
> + * usb_otg_register_gadget() - Register the gadget controller to OTG core
> + * @gadget:	gadget controller instance
> + * @ops:	gadget interface ops
> + *
> + * This is used by the USB gadget stack to register the gadget controller
> + * to the OTG core. Gadget controller must not be started by the
> + * caller as it is left up to the OTG state machine to do so.
> + *
> + * Returns: 0 on success, error value otherwise.
> + */
> +int usb_otg_register_gadget(struct usb_gadget *gadget,
> +			    struct otg_gadget_ops *ops)
> +{
> +	struct usb_otg *otg;
> +	struct device *gadget_dev =3D &gadget->dev;
> +	struct device *otg_dev =3D gadget->otg_dev;
> +
> +	if (!otg_dev)
> +		return -EINVAL;	/* we're definitely not OTG */
> +
> +	/* we're otg but otg controller might not yet be registered */
> +	mutex_lock(&otg_list_mutex);
> +	otg =3D usb_otg_get_data(otg_dev);
> +	mutex_unlock(&otg_list_mutex);
> +	if (!otg) {
> +		dev_dbg(gadget_dev,
> +			"otg: controller not yet registered, deferring.\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	mutex_lock(&otg->fsm.lock);
> +	if (otg->gadget) {
> +		dev_err(otg_dev, "otg: gadget already registered with otg\n");
> +		mutex_unlock(&otg->fsm.lock);
> +		return -EINVAL;
> +	}
> +
> +	otg->gadget =3D gadget;
> +	otg->gadget_ops =3D ops;
> +	dev_info(otg_dev, "otg: gadget %s registered\n",
> +		 dev_name(&gadget->dev));
> +
> +	/* FSM will be started in usb_otg_gadget_ready() */
> +	mutex_unlock(&otg->fsm.lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_register_gadget);
> +
> +/**
> + * usb_otg_unregister_gadget() - Unregister the gadget controller from O=
TG core
> + * @gadget:	gadget controller
> + *
> + * This is used by the USB gadget stack to unregister the gadget control=
ler
> + * from the OTG core. Ensures that gadget controller is not running
> + * on successful return.
> + *
> + * Returns: 0 on success, error value otherwise.
> + */
> +int usb_otg_unregister_gadget(struct usb_gadget *gadget)
> +{
> +	struct usb_otg *otg;
> +	struct device *gadget_dev =3D &gadget->dev;
> +	struct device *otg_dev =3D gadget->otg_dev;
> +
> +	if (!otg_dev)
> +		return -EINVAL;
> +
> +	mutex_lock(&otg_list_mutex);
> +	otg =3D usb_otg_get_data(otg_dev);
> +	mutex_unlock(&otg_list_mutex);
> +	if (!otg) {
> +		dev_err(gadget_dev,
> +			"otg: gadget %s wasn't registered with otg\n",
> +			dev_name(&gadget->dev));
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&otg->fsm.lock);
> +	if (otg->gadget !=3D gadget) {
> +		mutex_unlock(&otg->fsm.lock);
> +		dev_err(otg_dev, "otg: gadget %s wasn't registered with otg\n",
> +			dev_name(&gadget->dev));
> +		return -EINVAL;
> +	}
> +
> +	/* FSM must be stopped in usb_otg_gadget_ready() */
> +	if (otg->gadget_ready) {
> +		dev_err(otg_dev,
> +			"otg: gadget %s unregistered before being unready, forcing stop\n",
> +			dev_name(&gadget->dev));
> +		usb_otg_stop_fsm(otg);
> +	}
> +
> +	otg->gadget =3D NULL;
> +	mutex_unlock(&otg->fsm.lock);
> +
> +	dev_info(otg_dev, "otg: gadget %s unregistered\n",
> +		 dev_name(&gadget->dev));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_unregister_gadget);
> +
> +/**
> + * usb_otg_gadget_ready() - Notify gadget function driver ready status
> + * @gadget:	gadget controller
> + * @ready:	0: function driver ready, 1: function driver not ready
> + *
> + * Notify the OTG core about status of the gadget function driver.
> + * As OTG core is responsible to start/stop the gadget controller, it
> + * must be aware when the gadget function driver is available or not.
> + * This function is used by the Gadget core to inform the OTG core
> + * about the gadget function driver readyness.
> + *
> + * Return: 0 on sucess, error value otherwise.
> + */
> +int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
> +{
> +	struct usb_otg *otg;
> +	struct device *gadget_dev =3D &gadget->dev;
> +	struct device *otg_dev =3D gadget->otg_dev;
> +
> +	if (!otg_dev)
> +		return -EINVAL;
> +
> +	mutex_lock(&otg_list_mutex);
> +	otg =3D usb_otg_get_data(otg_dev);
> +	mutex_unlock(&otg_list_mutex);
> +	if (!otg) {
> +		dev_err(gadget_dev,
> +			"otg: gadget %s wasn't registered with otg\n",
> +			dev_name(&gadget->dev));
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&otg->fsm.lock);
> +	if (otg->gadget !=3D gadget) {
> +		mutex_unlock(&otg->fsm.lock);
> +		dev_err(otg_dev, "otg: gadget %s wasn't registered with otg\n",
> +			dev_name(&gadget->dev));
> +		return -EINVAL;
> +	}
> +
> +	/* Start/stop FSM & gadget */
> +	otg->gadget_ready =3D ready;
> +	if (ready)
> +		usb_otg_start_fsm(otg);
> +	else
> +		usb_otg_stop_fsm(otg);
> +
> +	dev_dbg(otg_dev, "otg: gadget %s %sready\n", dev_name(&gadget->dev),
> +		ready ? "" : "not ");
> +
> +	mutex_unlock(&otg->fsm.lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_gadget_ready);
> +
> +MODULE_LICENSE("GPL");

GPL or GPL 2-only?

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index f4fc0aa..1d74fb8 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -328,6 +328,7 @@ struct usb_gadget_ops {
>   * @in_epnum: last used in ep number
>   * @mA: last set mA value
>   * @otg_caps: OTG capabilities of this gadget.
> + * @otg_dev: OTG controller device, if needs to be used with OTG core.

do you really know of any platform which has a separate OTG controller?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ58bAAoJEIaOsuA1yqRE2BwP/2QCOfTZFnNtLJhcDwoYD/Qu
zJLSby+hNTgqqXuspIOihDCjTJ+RPKb26r4heJj12B79RcqsvUzH2rt0uQmxkrG9
/zi16tyqWZKfNcM01VnClVSU7BZ9ohJp9xUKoRjQI/GDwv0/wwJu3IrKOsg2G2xx
Miw41pwwuCpIsvNQ6x3UvBufuW0CCk/pmK1AW5u12IYTfJtn52czEHRQocEO8Z6z
oSPm+5ltamdjYs/BSylVtdDte8jNM5Pr81wgm8IcdohplZcEiVd1xG8NZBUYcPZS
uRsepxuB45tHOJjADU0OUGuzRpooRniHrxHOyMQQUqAsyopPXGdgOBia1x/eTzmI
z+e3rX5vFLg+W3oSZC2ukVGHevYQUmAOK2MZYsCtYJqwh+h+eLxP2/UiPYawpwjD
TWM3JHWD3OtaAmFq+htH0aNowkZ1Vg9ZYHva2A3p1rqHl/44XTywbfCKtMP9IYKI
ueg4o2K9JEADdHLKB0e0gp0T2HAinr+NZSJGkFu20AtVZI9AfO7Qo6EvwNXzFrzq
BCHMmtvDWiH0Wf0BTg3ERNr8NTDDFbwOV5vRNihXVoWO8QGt8unGFxNLTkQRsRuo
9sQQr0fa6vuoNWGpdD7eBI/W2mEdzx6IQnNbIbO9tioVRBmEE0WUDwrlX4SiGG4V
U/IDyzZI0nNSVUYGU7Hq
=zM94
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
