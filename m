From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC PATCH 2/9] HSI: Low Level Driver core
Date: Fri, 30 Oct 2009 14:56:43 +0200
Message-ID: <20091030125643.GK31472@nokia.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com>
 <1256896808-20152-3-git-send-email-s-jan@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26410 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742AbZJ3M5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 08:57:18 -0400
Content-Disposition: inline
In-Reply-To: <1256896808-20152-3-git-send-email-s-jan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sebastien Jan <s-jan@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chinea Carlos (Nokia-D/Helsinki)" <Carlos.Chinea@nokia.com>

Hi,

On Fri, Oct 30, 2009 at 11:00:01AM +0100, ext Sebastien Jan wrote:
> +static int __init reg_hsi_dev_ch(struct hsi_dev *hsi_ctrl, unsigned int p,
> +                                unsigned int ch)
> +{
> +       struct hsi_device *dev;
> +       struct hsi_port *port = &hsi_ctrl->hsi_port[p];
> +       int err;
> +
> +       dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +       if (!dev)
> +               return -ENOMEM;
> +
> +       dev->n_ctrl = hsi_ctrl->id;
> +       dev->n_p = p;
> +       dev->n_ch = ch;
> +       dev->ch = &port->hsi_channel[ch];
> +       dev->device.bus = &hsi_bus_type;
> +       dev->device.parent = hsi_ctrl->dev;
> +       dev->device.release = hsi_dev_release;
> +       if (dev->n_ctrl < 0)
> +               dev_set_name(&dev->device, "omap_hsi-p%u.c%u", p, ch);
> +       else
> +               dev_set_name(&dev->device, "omap_hsi%d-p%u.c%u", dev->n_ctrl, p,
> +                            ch);
> +
> +       err = device_register(&dev->device);
> +       if (err >= 0) {
> +               write_lock_bh(&port->hsi_channel[ch].rw_lock);
> +               port->hsi_channel[ch].dev = dev;
> +               write_unlock_bh(&port->hsi_channel[ch].rw_lock);
> +       } else {
> +               kfree(dev);
> +       }
> +       return err;
> +}

this will make a client's probe() function to be called twice, no ??

you should/could have a hsi_new_dummy() like on i2c ??

> +static int __init hsi_request_mpu_irq(struct hsi_port *hsi_p)

this should be done by hsi-omap.ko driver.

> +static int __init hsi_request_cawake_irq(struct hsi_port *hsi_p)

ditto.

> +static int __init hsi_ports_init(struct hsi_dev *hsi_ctrl)

ditto.

> +static int __init hsi_request_gdd_irq(struct hsi_dev *hsi_ctrl)

ditto.

> +static int __init hsi_controller_init(struct hsi_dev *hsi_ctrl,
> +                                     struct platform_device *pd)

ditto.

-- 
balbi
