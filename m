From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Tue, 22 Jun 2010 12:28:09 +0300
Message-ID: <20100622092809.GX12255@atomide.com>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
 <20100621135120.24299.98499.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DIOMP1UsTsWJauNi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64905 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab0FVJ17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 05:27:59 -0400
Content-Disposition: inline
In-Reply-To: <20100621135120.24299.98499.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100621 16:45]:
> The TLS register is only available on ARM1136 r1p0 and later.
> Set HWCAP_TLS flags if hardware TLS is available.
> 
> Note that we now use 0xffff0ff4 for flagging software TLS to
> __kuser_get_tls, and 0xffff0ff8 for storing the software TLS value.

Forgot my own earlier comment to check only for ARM1136, will update
with this patch.

Tony

--DIOMP1UsTsWJauNi
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="tls-1136.patch"

Check only for 1136.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -277,8 +277,8 @@ static void __init feat_v6_fixup(void)
 	if (id & 0x000f0000 != 0x00070000)
 		return;
 
-	/* HWCAP_TLS is available only on V6 r1p0 and later */
-	if (((id >> 20) & 3) == 0)
+	/* HWCAP_TLS is available only on 1136 r1p0 and later */
+	if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
 		elf_hwcap &= ~HWCAP_TLS;
 }
 #else

--DIOMP1UsTsWJauNi--
