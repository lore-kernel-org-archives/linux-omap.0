From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] arm/omap: simplify conditional
Date: Thu, 07 Oct 2010 16:53:59 +0300
Message-ID: <1286459639.28499.1064.camel@tubuntu.research.nokia.com>
References: <20101005203154.0ba412d2@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:51196 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524Ab0JGNyF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 09:54:05 -0400
In-Reply-To: <20101005203154.0ba412d2@absol.kitzblitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nicolas Kaiser <nikai@nikai.net>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2010-10-05 at 20:31 +0200, ext Nicolas Kaiser wrote:
> Simplify conditional: (a || (!a && !b)) => (a || !b)
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---

Thanks, applied.

 Tomi


