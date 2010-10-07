From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP3: DSS2: DSI: Remove extra iounmap in error path
Date: Thu, 07 Oct 2010 16:39:02 +0300
Message-ID: <1286458742.28499.1060.camel@tubuntu.research.nokia.com>
References: <1286450884-3597-1-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:57575 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760593Ab0JGNj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 09:39:26 -0400
In-Reply-To: <1286450884-3597-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-10-07 at 13:28 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> iounmap is already done in label err2: so extra iounmap in
> the error handling path could be removed.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

Good catch, thanks!

 Tomi


