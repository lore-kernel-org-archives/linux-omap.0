From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/5] OMAP: DSS: fixes for rc
Date: Fri, 15 Apr 2011 10:32:37 -0700
Message-ID: <BANLkTim0J5dHLq_U_yMEZ=nn_qxdUXjt_g@mail.gmail.com>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62249 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab1DORci (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 13:32:38 -0400
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Fri, Apr 15, 2011 at 1:11 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Some small fixes to OMAP DSS for the next rc.
>
> I will send a pull request to Paul Mundt soon if there are no problems with the
> patches.

Tested on Overo (both 35XX and 37XX versions).

This patch series fixes the earlier issue of no video output on 37XX boards.

Tested-by: Steve Sakoman <steve@sakoman.com>
