From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Tue, 29 Sep 2009 09:43:41 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A8789C95AC1@dlee01.ent.ti.com>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>,<1254234160.23991.1.camel@tubuntu>
 <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40814 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbZI2On6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 10:43:58 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aguirre Rodriguez, Sergio Alberto wrote:
> And then, inside that function, an attempt of acquiring a
> mutex failed, because it wasn't initialized before trying it:
> 
> mutex_lock(&fbi->mm_lock);

I would like to stress that this does cause the kernel to crash during boot up because this is mutex not initialised before it is used.  

> BTW, this problem is found on current Linus tree, and in
> current l-o tree aswell, and i saw it on my 3430SDP VG5.0.1.

I am seeing this too on the beagle-board and so it appears to impact a few omap3 boards. 

Cheers
Jon