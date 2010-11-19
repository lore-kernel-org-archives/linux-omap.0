From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Fri, 19 Nov 2010 10:50:07 +0200
Message-ID: <20101119085007.GK6446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
 <1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45322 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769Ab0KSIuE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 03:50:04 -0500
Content-Disposition: inline
In-Reply-To: <1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Hi,

On Thu, Nov 18, 2010 at 01:15:42PM -0600, Hari Kanigeri wrote:
>In the current mailbox driver, the mailbox internal pointer for
>callback can be directly manipulated by the Users, so a second
>User can easily corrupt the first user's callback pointer.
>The initial effort to correct this issue can be referred here:
>https://patchwork.kernel.org/patch/107520/
>
>Along with fixing the above stated issue, this patch  adds the
>flexibility option to register notifications from
>multiple readers to the events received on a mailbox instance.
>The discussion regarding this can be referred here.
>http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30671.html
>
>Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>

Personally, I don't like this patch. I think it's much better to have a
per-message callback then a "global" notification which all users will
listen to.

What will happen is that every user will have to check if every message
belongs to them based on the notifications.

Imagine a hypothetical situation where you have 100 users each with 100
messages. You will have 100 * 100 (10.000)
"does-this-message-belongs-to-me" checks.

Rather than doing it this way, I would, as the easiest path, add a
"callback" parameter to omap_mbox_request_send() and then, internally,
allocate a e.g. struct omap_mbox_request and add that to a list of pending
messages. Something like:

struct omap_mbox_request {
	struct omap_mbox	*mbox;
	int			(*complete)(void *context);
	void			*context;
	void			*buf;
	unsigned		len;
	struct list_head	list;
};

[...]

int omap_mbox_request_send(struct omap_mbox *mbox, mbox_msg_t msg, int
		(*complete)(void *context), void *context, gfp_t flags)
{
	struct omap_mbox_queue	*mq = mbox->txq;
	struct omap_mbox_request	*req;
	int			ret = 0;
	int			len;

	req = kzalloc(sizeof(*req), flags);
	if (!req) {
		[...]
	}

	memcpy(req->buf, &msg, sizeof(msg));
	req->len = sizeof(msg));
	req->mbox = msg;
	req->complete = complete;
	req->context = context;
	INIT_LIST_HEAD(&req->list);

	list_add_tail(&req->list, &mq->req_list);

	/* kick the tasklet here */

	return 0;
}

then on your tasklet, you simply iterate over the list and start sending
one by one and calling callback when it completes. You would be giving
your users a more asynchronous API and you wouldn't need this notifier
which, IMO, isn't a good solution at all.

But hey, since you'd be doing so many changes, you might as well provide
a:

omap_mbox_alloc_req();

to allocate a struct omap_mbox_request and a

omap_mbox_queue();

to add a request to the list (simply rename omap_mbox_send to
omap_mbox_queue() and make the necessary changes, like changing the
prototype to omap_mbox_queue(struct omap_mbux *mbox, struct
omap_mbox_request *req);)

In any case, even though I don't like the solution, it's Hiroshi's
decision to take or not this patch :-p

-- 
balbi
