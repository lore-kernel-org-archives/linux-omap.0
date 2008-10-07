From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: [PATCH] MUSB: Fixes endpoint allocation logic
Date: Tue, 7 Oct 2008 11:21:43 -0700
Message-ID: <e5e6ade50810071121l60623de6r20848a8028b22f38@mail.gmail.com>
References: <1223372190-8050-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:45589 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYJGSVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 14:21:45 -0400
Received: by qw-out-2122.google.com with SMTP id 3so793131qwe.37
        for <linux-omap@vger.kernel.org>; Tue, 07 Oct 2008 11:21:43 -0700 (PDT)
In-Reply-To: <1223372190-8050-1-git-send-email-ajay.gupta@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Oct 7, 2008 at 2:36 AM, Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> musb->periodic[] flag was getting set for an endpoint even when only rx
> or tx is used.This patch adds two field musb->in[16] and musb->out[16]
> in place of musb->periodic[32] which will enable endpoint allocation
> flag setting on rx/tx basis of an endpoint.

To apply this I had to make some changes to an older patch, since it
used ->periodic:
http://marc.info/?l=linux-omap&m=122284678326859&w=2

It seems to be working fine.  But, is there a way to get the latest
versions of the pending MUSB patches?

- Nathan
