From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [ANNOUNCE] dspbridge: kill camelcase
Date: Tue, 23 Feb 2010 20:14:51 -0600
Message-ID: <4B848B9B.2030002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab0BXCOx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 21:14:53 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1O2Eqhl012502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 20:14:52 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o1O2Eqls029782
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 20:14:52 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1O2EqLr002010
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 20:14:52 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi All,

I'm currently working on removing camel case + hungarian notation from 
dspbridge code in the following branch:

dspbridge-next-camelcase on d.o-z

I'll appreciate if you can mail any unsent patch otherwise it will need 
to wait (and be rebased) after the camelcase changes.

If nobody disagrees I'll be marking dspbridge 0.2 (as per private 
discussion) in the upcoming days.

Thanks,

Omar
