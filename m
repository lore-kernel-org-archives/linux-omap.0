From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 12:03:27 +0100
Message-ID: <201002261203.27619.oliver@neukum.org>
References: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:35284 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934028Ab0BZLDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 06:03:55 -0500
In-Reply-To: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, stern@rowland.harvard.edu

Am Freitag, 26. Februar 2010 11:39:06 schrieb Ajay Kumar Gupta:
> +struct queue *create(void)
> +{
> +       struct queue *new;
> +       new = kmalloc(sizeof(struct queue), GFP_ATOMIC);
> +       if (!new)
> +               return NULL;
> +       new->next = NULL;
> +       return new;
> +}
> +void push_queue(struct musb *musb, struct urb *urb)
> +{
> +       struct queue *new, *temp;
> +
> +       new = create();
> +       new->urb = urb;

And you happily follow the NULL pointer in the error case.

> +
> +       temp = musb->qhead;
> +
> +       spin_lock(&musb->qlock);
> +       while (temp->next != NULL)
> +               temp = temp->next;
> +       temp->next = new;
> +       spin_unlock(&musb->qlock);
> +}

A design allocating memory in giveback is problematic. At least you need
to handle a failure to allocate memory. But you'd better handle this by putting
the list into the private part of the URB.

	Regards
		Oliver
