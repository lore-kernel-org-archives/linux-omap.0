From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 1/1] Registering sgx device and it's platform data
Date: Tue, 30 Mar 2010 11:45:21 +0300
Message-ID: <20100330084520.GF30597@nokia.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBF372@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29346 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649Ab0C3Iqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 04:46:37 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DEBF372@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Agarwal, Preshit" <preshit.agarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Tue, Mar 30, 2010 at 09:06:33AM +0200, ext Agarwal, Preshit wrote:
>diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
>new file mode 100644
>index 0000000..195df97
>--- /dev/null
>+++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
>@@ -0,0 +1,11 @@

you're missing the gpl header on this file.

-- 
balbi
