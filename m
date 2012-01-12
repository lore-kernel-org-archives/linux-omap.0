From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: linux-next problems
Date: Thu, 12 Jan 2012 17:58:48 +0200
Message-ID: <CAK=WgbbJsfdcjv86y6PC2w1jxCyApL-LFj8PvoKSQDL2e7m4iA@mail.gmail.com>
References: <1326382689.1896.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53624 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab2ALP7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 10:59:10 -0500
In-Reply-To: <1326382689.1896.12.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org

+ Stephen

Thanks, Tomi.

On Thu, Jan 12, 2012 at 5:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> I was trying to compile linux-next for OMAP, but it doesn't compile with
> the default configs.
...
> drivers/remoteproc/remoteproc_rpmsg.c:100:6: error: too few arguments to function 'vring_new_virtqueue'

This is due to a recent change in virtio.

Stephen, I guess this won't be relevant for more than a few days, but
can you please take this patch below to linux-next ?
(alternatively feel free just to squash this to the merge commit.
whatever is easiest for you.)

Thanks!
Ohad.

>From 305aefa86e84a161f2535e4302eaf8b2338eeff8 Mon Sep 17 00:00:00 2001
From: Ohad Ben-Cohen <ohad@wizery.com>
Date: Thu, 12 Jan 2012 09:26:57 +0200
Subject: [PATCH] remoteproc: don't use virtio's weak barriers

When creating a virtqueue for rpmsg, tell virtio we're not interested
in "weak" smp barriers, since we're talking to a real device.

On ARM, this means using a DSB instead of a DMB, which is needed
for platforms that kick the remote processor using some kind of
a mailbox device mapped to Device memory (otherwise the kick can
jump ahead and wake the remote processor before it has observed
the changes to the vrings).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/remoteproc_rpmsg.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_rpmsg.c
b/drivers/remoteproc/remoteproc_rpmsg.c
index f30be4c..4f73e81 100644
--- a/drivers/remoteproc/remoteproc_rpmsg.c
+++ b/drivers/remoteproc/remoteproc_rpmsg.c
@@ -96,7 +96,11 @@ static struct virtqueue *rp_find_vq(struct
virtio_device *vdev,

 	dev_dbg(rproc->dev, "vring%d: va %p qsz %d\n", id, addr, len);

-	vq = vring_new_virtqueue(len, AMP_VRING_ALIGN, vdev, addr,
+	/*
+	 * Create the new vq, and tell virtio we're not interested in
+	 * the 'weak' smp barriers, since we're talking with a real device.
+	 */
+	vq = vring_new_virtqueue(len, AMP_VRING_ALIGN, vdev, false, addr,
 					rproc_virtio_notify, callback, name);
 	if (!vq) {
 		dev_err(rproc->dev, "vring_new_virtqueue %s failed\n", name);
-- 
1.7.5.4
