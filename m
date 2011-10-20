From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Thu, 20 Oct 2011 14:58:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328693C85@dbde02.ent.ti.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
 <1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
 <CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
 <CAAL8m4ztvsGiJz_2uPd8rtEYSsVv24oSPi4eK==U30k==75muA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45578 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960Ab1JTJ3A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Oct 2011 05:29:00 -0400
In-Reply-To: <CAAL8m4ztvsGiJz_2uPd8rtEYSsVv24oSPi4eK==U30k==75muA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Govindraj,

On Thu, Oct 20, 2011 at 14:09:22, Govindraj wrote:
> Yes correct, I missed that part here is the updated patch [1]
> Updated change-log for debug/loglevel and checked console_loglevel
> in addition to debug in bootargs.

Perhaps checking console_loglevel only is sufficient, if I am not
missing anything, passing "debug" thr' bootargs only causes loglevel
to be set to 10 and nothing else.

Regards
Afzal

