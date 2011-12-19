From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: ZOOM2 doesn't boot on upstream kernel
Date: Mon, 19 Dec 2011 18:56:14 +0200
Message-ID: <CAMP44s2WRGBP8TP6v-2fZGywgdZ_N719D4QJtnxao4cZUco7Rg@mail.gmail.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
	<AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
	<A24693684029E5489D1D202277BE894456224D59@dlee02.ent.ti.com>
	<loom.20111216T082358-46@post.gmane.org>
	<20111216205302.GN32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48599 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab1LSQ4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 11:56:15 -0500
Received: by pbdu13 with SMTP id u13so1942280pbd.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 08:56:14 -0800 (PST)
In-Reply-To: <20111216205302.GN32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: deepthi <deepthi_kiran@mindtree.com>, linux-omap@vger.kernel.org

On Fri, Dec 16, 2011 at 10:53 PM, Tony Lindgren <tony@atomide.com> wrote:
> You should use ttyO for the omap ports, but zoom debug board
> has external 8250 ftdi ports, so those show up as ttyS and
> not ttyO.

Plus that was changed on 2.6.36 (or after?) and he is using 2.6.35.

-- 
Felipe Contreras
