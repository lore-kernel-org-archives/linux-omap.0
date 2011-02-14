From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 1/7] omap: clock: Check for enable/disable ops support
Date: Mon, 14 Feb 2011 17:45:36 +0530
Message-ID: <61921a70b7d31d38192210257bca3c0e@mail.gmail.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
 <1297159838-30282-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102121615130.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51094 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753418Ab1BNMPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 07:15:40 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so5473504fxm.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 04:15:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102121615130.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Sunday, February 13, 2011 4:48 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com; khilman@ti.com;
santosh.shilimkar@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 1/7] omap: clock: Check for enable/disable ops
support
>
> On Tue, 8 Feb 2011, Rajendra Nayak wrote:
>
> > Check if enable/disable operations are supported for a given
> > clock node before attempting to call them.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> Thanks, queued in branch 'clk_a_2.6.39' of
git://git.pwsan.com/linux-2.6.

This patch seems to be needed in clk_autoidle_a_2.6.39 too,
without which there is an abort at boot on OMAP4.

Regards,
Rajendra

>
> This patch is integrated as part of the tag
> 'tmp-integration-2.6.39-20110212-003' and the branch
'integration-2.6.39'
> of git://git.pwsan.com/linux-integration.
>
>
> - Paul
