From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/1] omap3: Save and restore CM_AUTOIDLE_PLL across off
 mode
Date: Tue, 8 Mar 2011 13:54:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081354090.10981@utopia.booyaka.com>
References: <1297353724-11665-1-git-send-email-premi@ti.com> <1297353724-11665-2-git-send-email-premi@ti.com> <alpine.DEB.2.00.1103041540540.10981@utopia.booyaka.com> <B85A65D85D7EB246BE421B3FB0FBB593024C0E5A55@dbde02.ent.ti.com>
 <c9be31ca3dab99320a409e957330506c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36171 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532Ab1CHUzA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 15:55:00 -0500
In-Reply-To: <c9be31ca3dab99320a409e957330506c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sanjeev,

On Mon, 7 Mar 2011, Vishwanath Sripathy wrote:

> As per OMAP3630 TRM Section 26.5, register CM_AUTOIDLE_PLL is supposed to
> be restored by ROM code. The PM code should only store these registers
> before entering off mode. So only thing that needs to be done in this
> patch set is to save these registers.

If you agree with Vishwa's suggestion, could you please test it and see 
whether it is sufficient?


- Paul
