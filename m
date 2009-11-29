From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/8] Series short description
Date: Sun, 29 Nov 2009 15:33:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBE6475D@dbde02.ent.ti.com>
References: <20091126001646.1546.34352.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35266 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316AbZK2KD3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Nov 2009 05:03:29 -0500
In-Reply-To: <20091126001646.1546.34352.stgit@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, November 26, 2009 5:49 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 0/8] Series short description
> 
> Hi all,
> 
> Here are some omap mux updates for review. These
> are intended for the v2.6.33 merge window.
> 
> Initially this series changes the omap34xx mux
> code, I'm planning on adding 3630, 2420, and 2430
> code later on.
> 
> There are several reasons why we need better mux
> code:
> 
> - We want to make the mux code more generic and this
>   will allow us to use the internal signal names and
>   gpio numbers instead of mux register offsets. The
>   internal signal names stay the same across omap
>   generations for some devices.
> 
> - We need to map mux registers to GPIO registers for
>   dynamic muxing of the GPIO pins during off-idle.
> 
> - We want to be able to override the bootloader mux
>   values for the modded boards, such as the Beagle.
> 
> - We want to have the mux signals and balls available
>   under debugfs for debugging new drivers.
> 
> Some of these might eventually work for other archs
> too, so let me know if you have any comments on that.

Thanks for the series. Managing mux is always an issue and most time consuming one. This series will improve mux code greatly.

Regards,
Santosh
 
