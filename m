From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [Query][omap iommu] Consulting iommu if a physical region is
 "mappable" before actually mapping it
Date: Mon, 3 May 2010 14:09:11 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B791E48@dlee03.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944550BB017@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55047 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460Ab0ECTJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 15:09:16 -0400
In-Reply-To: <A24693684029E5489D1D202277BE8944550BB017@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sergio,

> 
> Can the iommu driver be "consulted" if a certain area (contiguous or not)
> can be mapped or not, before even trying to do it?
>

-- As long as there are physical pages backing the area it should be mappable right ? 

Thank you,
Best regards,
Hari
