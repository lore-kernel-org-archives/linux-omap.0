From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] video/omap: remove mux.h include
Date: Tue, 05 Oct 2010 13:02:22 +0300
Message-ID: <1286272942.2358.29.camel@tubuntu.research.nokia.com>
References: <20101004174344.21577085@absol.kitzblitz>
	 <20101004175429.GW3117@atomide.com>
	 <20101004203842.088b0cb2@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53617 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab0JEKCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 06:02:39 -0400
In-Reply-To: <20101004203842.088b0cb2@absol.kitzblitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nicolas Kaiser <nikai@nikai.net>
Cc: Tony Lindgren <tony@atomide.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2010-10-04 at 20:38 +0200, ext Nicolas Kaiser wrote:
> Including mux.h should no longer be needed for omap2/3/4 SoCs
> outside arch/arm/mach-omap2 files.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>

Thanks, applied to my tree.

 Tomi


