From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v6 0/6] PM QoS: implement the OMAP low level constraints
 management code
Date: Mon, 16 Jan 2012 13:04:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201161301450.16675@utopia.booyaka.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com> <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54072 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab2APUE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jan 2012 15:04:59 -0500
In-Reply-To: <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

Hi

On Mon, 16 Jan 2012, Jean Pihet wrote:

> Speaking of the locking, currently a spinlock is used and it could be
> replaced by a more efficient mutex. This is ok at the condition that
> this code is not called from interrupt context?
> 
> Kevin,
> Do you know if the per-device constraint code can be called from
> interrupt context?

It can't be.  It uses a mutex itself.  So a mutex is what we want.  Take a 
look at drivers/base/power/qos.c:dev_pm_qos_update_request() (included 
below)


- Paul


/**
 * dev_pm_qos_update_request - modifies an existing qos request
 * @req : handle to list element holding a dev_pm_qos request to use
 * @new_value: defines the qos request
 *
 * Updates an existing dev PM qos request along with updating the
 * target value.
 *
 * Attempts are made to make this code callable on hot code paths.
 *
 * Returns 1 if the aggregated constraint value has changed,
 * 0 if the aggregated constraint value has not changed,
 * -EINVAL in case of wrong parameters, -ENODEV if the device has been
 * removed from the system
 */
int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
			      s32 new_value)
{
	int ret = 0;

	if (!req) /*guard against callers passing in null */
		return -EINVAL;

	if (WARN(!dev_pm_qos_request_active(req),
		 "%s() called for unknown object\n", __func__))
		return -EINVAL;

	mutex_lock(&dev_pm_qos_mtx);

	if (req->dev->power.constraints) {
		if (new_value != req->node.prio)
			ret = apply_constraint(req, PM_QOS_UPDATE_REQ,
					       new_value);
	} else {
		/* Return if the device has been removed */
		ret = -ENODEV;
	}

	mutex_unlock(&dev_pm_qos_mtx);
	return ret;
}

