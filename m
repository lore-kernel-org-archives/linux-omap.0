From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PM-WIP-OPP] [PATCH 2/2]: Change return value from ERR_PTR(..)
 to NULL in opp layer
Date: Sat, 16 Jan 2010 08:06:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E196B370@dbde02.ent.ti.com>
References: <1263553383.3490.44.camel@boson>,<878wbz44qm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47269 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758195Ab0APCi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 21:38:27 -0500
In-Reply-To: <878wbz44qm.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>> Returning NULL pointer from the OPP APIs instead of ERR_PTR where
>> return struct omap_opp *. This is because there is no inherent value in
>> returning ERR_PTR from the opp layer. Returning NULL serves the purpose.

>NAK.

>Using ERR_PTR allows returning different types of error conditions,
>and is common practice across the kernel.
Yes, it is true that it is a common practice but in case of the OPP layer I did not 
see any purpose. The caller of the APIs returning struct omap_opp * can just
check for NULL value for failure.