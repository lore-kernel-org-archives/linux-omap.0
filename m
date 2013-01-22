From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 10:24:26 +0100
Message-ID: <1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
	 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
	 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
	 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
	 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54704 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab3AVJY2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 04:24:28 -0500
In-Reply-To: <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Matt Porter <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon\\, Nishanth" <nm@ti.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "Hiremath\\, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel\\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 2013-01-22 at 02:24 +0000, Paul Walmsley wrote:
> Regarding the AM33xx test failures with appended DTBs, it would be very 
> helpful if especially the TI people could try reproducing the problem.
> Otherwise it's going to cause problems with merging any new AM33xx 
> patches, since I won't be able to test them without additional work.  
> Plus, this is something that used to work up until d01e4afd, so something 
> isn't right.

Just a guess, but there can be problems when the appended DTB crosses an
1MB boundary. See this mail for details and a patch:
http://www.spinics.net/lists/arm-kernel/msg216898.html

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

