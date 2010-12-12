From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Inconsistent lock state caused by omap_mbox_msg_send() called
 from tidspbridge
Date: Sun, 12 Dec 2010 16:22:38 +0200
Message-ID: <AANLkTimKQmrk+zw_kO2pjYY_6Oz3DW8EQQhfUCYRkpNa@mail.gmail.com>
References: <201012121344.51245.laurent.pinchart@ideasonboard.com> <1292163339.2375.2.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f170.google.com ([209.85.214.170]:40352 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab0LLOW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Dec 2010 09:22:59 -0500
Received: by iwn6 with SMTP id 6so7838045iwn.1
        for <linux-omap@vger.kernel.org>; Sun, 12 Dec 2010 06:22:59 -0800 (PST)
In-Reply-To: <1292163339.2375.2.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org

On Sun, Dec 12, 2010 at 4:15 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> I noticed this too, but this patch should fix it:
>
> https://patchwork.kernel.org/patch/365292/

True. And in this patch the move to spin_lock_bh() is justifiable,
too, since it adds a sending path which is parallel to the mailbox
tasklet.

>
> Ionut.
>
>
