From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/5] OMAP4: hwmod data: Fix hwmod entries order
Date: Mon, 13 Dec 2010 19:07:32 -0800
Message-ID: <87d3p52gsr.fsf@deeprootsystems.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
	<1291937615-18571-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:53868 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab0LNDHh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 22:07:37 -0500
Received: by gxk19 with SMTP id 19so114850gxk.11
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 19:07:36 -0800 (PST)
In-Reply-To: <1291937615-18571-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 10 Dec 2010 00:33:31 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>

Benoit Cousson <b-cousson@ti.com> writes:

> The original OMAP4 hwmod data files is fully generated from HW
> database. But since the file is introduced incrementaly along
> with driver that uses the data, it has to be splitted by the driver
> owner and then re-merged by the maintainer.
> Because of the similarity of the data, git is completely lost
> during such merge and thus the data does not look like the original one
> at the end.
>
> Re-order properly the structures to stay in sync with original data set.
>
> Add a comment that does contain all the IPs that can have a hwmod, but
> do not have it in the file for the moment. It gives a good indication
> of the progress.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Cc: Charulatha V <charu@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

My (mostly) blind git merges caused this problem in the first place.
Sorry.

Kevin
