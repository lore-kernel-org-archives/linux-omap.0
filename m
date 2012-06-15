From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
Date: Fri, 15 Jun 2012 10:50:10 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A569@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
 <4FD6783D.9030208@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F7C@DBDE01.ent.ti.com>
 <4FD78748.2080504@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998955@DBDE01.ent.ti.com>
 <4FD8B55E.6010701@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9996FC@DBDE01.ent.ti.com>
 <4FDA5252.2050401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45971 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919Ab2FOKuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 06:50:16 -0400
In-Reply-To: <4FDA5252.2050401@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Fri, Jun 15, 2012 at 02:36:26, Hunter, Jon wrote:
> On 06/14/2012 03:48 AM, Mohammed, Afzal wrote:

> > What I meant is we are not dependent on absolute value of flag to
> > find waitpin, and I disagree in depending on its absolute value,
> > which can change, while flag would be the same.
> 
> As long as we can avoid having multiple #defines for the same thing, I
> don't mind how it is done.

I feel such a dependency is fragile

Regards
Afzal
