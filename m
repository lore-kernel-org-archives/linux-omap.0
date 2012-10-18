From: Afzal Mohammed <x0148406@ti.com>
Subject: Re: [PATCH 0/4] OMAP-GPMC generic timing migration
Date: Thu, 18 Oct 2012 10:56:13 +0530
Message-ID: <507F92F5.6080906@ti.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com> <20121011144756.GB12552@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com> <20121015160154.GB15569@atomide.com> <507D050D.2090402@ti.com> <507E455F.7060703@ti.com> <507ECB31.8030006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab2JRF0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 01:26:30 -0400
In-Reply-To: <507ECB31.8030006@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <David.Woodhouse@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Daniel,

On Wednesday 17 October 2012 08:43 PM, Daniel Mack wrote:
> On 17.10.2012 07:42, Afzal Mohammed wrote:

>> I doubt whether auxdata would help here, it seems using
>> compatible field alone would help in deciding relevant
>> custom timing routine. Whether we want this kind of
>> peripheral knowledge in gpmc driver instead of using
>> generic timing routine has to be decided though.

> Another thing that might be worth thinking about is that apart from the
> GPMC host controller and the peripherals, there could be other
> components like level shifters or series resistors on the board that
> limit the maximum speed of transactions. So in fact we might be better
> off storing all that timing details in the DT, as they are in fact
> highly application specific.

Yes, making it future proof for these kind of scenarios was one
of the reason's that initially triggered generic timing path.

Regards
Afzal
