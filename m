From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: [PATCH 0/3] omap3: pm: removes hardcoded VDD1/2 OPP values and make
 threshold generic
Date: Thu, 19 Nov 2009 16:52:29 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A61@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940254169ADA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40794 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbZKSLXF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 06:23:05 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940254169ADA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

With 3 patches I am trying to 
1. Remove hardcoded VDD1 OPP values and make threshold generic
2. Remove hardcoded VDD2 OPP values and make threshold generic
3. adding new api inplace of MIN/MAX_VDD1/VDD2_OPP 
         to support 3630 OPP constraning along with the existing 3430 constraint.

Patches are rebased on the 2.6.32-rc7.

Patches have been tested for 3630 for 2.6.32-rc5.

========================
Thanks and Regards
Vijay
