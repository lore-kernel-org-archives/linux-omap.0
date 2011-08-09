From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 0/3] Add support for TI814X processor series
Date: Tue, 9 Aug 2011 23:52:00 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABB099E0@dbde02.ent.ti.com>
References: <1312479869-21948-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35273 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab1HISWM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 14:22:12 -0400
In-Reply-To: <1312479869-21948-1-git-send-email-hemantp@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Hello,

Pedanekar, Hemant wrote on Thursday, August 04, 2011 11:14 PM:

> This patch set adds support for DM814x, C6A814x and AM387x
> device series having
> Cortex-A8 MPU.
> 
> The technical documents are available from following link:
> 
> http://focus.ti.com/docs/prod/folders/print/tms320dm8148.html
> 
> This series is referred in code as TI814X.
> 
> Since these devices share similar architecture as TI816X
> devices, existing
> TI816X code is updated to accomodate TI814X support. The code
> shared across
> TI816X and TI814X devices is updated with TI81XX/ti81xx
> prefix as applicable,
> while maintaining cpu_is_ti816x() and cpu_is_ti814x() to
> distinguish specific
> execution differences.
> 
> Hemant Pedanekar (3):
>   TI81XX: Prepare for addition of TI814X support
>   TI814X: Add cpu type macros and detection support
>   TI814X: Create board support and enable build for TI8148 EVM
> 
[...]

Any comments on this patch set?
Thanks.

   Hemant