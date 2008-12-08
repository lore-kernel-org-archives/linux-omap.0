From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Mon, 8 Dec 2008 19:42:35 -0200
Message-ID: <20081208194235.4991873d@pedra.chehab.org>
References: <5d5443650811261044w30748b75w5a47ce8b04680f79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:56027 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYLHVms (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 16:42:48 -0500
In-Reply-To: <5d5443650811261044w30748b75w5a47ce8b04680f79@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: v4l <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Thu, 27 Nov 2008 00:14:51 +0530
"Trilok Soni" <soni.trilok@gmail.com> wrote:

> +
> +/*
> + *
> + * DMA hardware.
> + *
> + */
> +
> +/* Ack all interrupt on CSR and IRQSTATUS_L0 */
> +static void omap24xxcam_dmahw_ack_all(unsigned long base)

Oh, no! yet another dma video buffers handling...

Soni, couldn't this be converted to use videobuf?

Each time I see a driver implementing a different buffer schema I want to cry...

Those handlers seem to be very complex and different buffers implementations
lead to different errors that requires lots of time to fix. We should really
work to improve a common buffer handler that work fine for all drivers.

Cheers,
Mauro
