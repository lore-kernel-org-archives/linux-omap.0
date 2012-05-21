From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 08:52:39 -0700
Message-ID: <CA+Bv8XYYe_3xprvVORXkdX2N54iDn_2v7GXndB6+cCtU0bLhcA@mail.gmail.com>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50326 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752020Ab2EUPwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 11:52:41 -0400
Received: by lahd3 with SMTP id d3so3584980lah.19
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 08:52:39 -0700 (PDT)
In-Reply-To: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

The correct patch for this was sent earlier:

http://www.spinics.net/lists/linux-omap/msg70042.html
"[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"

On Mon, May 21, 2012 at 2:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Tony,
>
> There is a bug in the for-l-o-3.5 branch I sent earlier, causing the DVI driver
> to fail to request the power-down GPIO. This patch fixes it.


The correct patch for this was sent earlier:

http://www.spinics.net/lists/linux-omap/msg70042.html
"[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio"
