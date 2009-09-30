From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Wed, 30 Sep 2009 11:32:01 +0300
Message-ID: <1254299521.23991.53.camel@tubuntu>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
	 ,<1254234160.23991.1.camel@tubuntu>
	 <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
	 ,<1254236004.23991.17.camel@tubuntu>
	 <A24693684029E5489D1D202277BE89444B781B72@dlee02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E73940436C4483D@dbde02.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50998 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbZI3IcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 04:32:07 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436C4483D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2009-09-29 at 20:26 +0200, ext Hiremath, Vaibhav wrote:

> Tomi,
> 
> Don't you think we should also make use of mm_lock in new OMAP2 Fbdev driver, to be more specific and safer side?
> 

Hmm yes, I think we should. One more thing to the TODO list =)

 Tomi


