From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Wed, 25 Apr 2012 13:38:43 +0200
Message-ID: <4F97E243.6000500@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com> <4F97B891.1020601@ti.com> <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47389 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758862Ab2DYLiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 07:38:50 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 4/25/2012 12:20 PM, Hiremath, Vaibhav wrote:
> On Wed, Apr 25, 2012 at 14:10:49, Cousson, Benoit wrote:

...

>> That will not change anything, the point is that MODULEMODE_SWCTRL is
>> uses for module control, not for clock directly, and that's why it is
>> handled by the hwmod.
>>
>> That will just replace the main_clk from the hwmod with the parent of
>> the current modulemode nodes. Only the enable/disable part will be
>> handled, if that node used to have a div, then the parent will handle that.
>>
>> Today this module mode clock node is just a duplication of the hwmod
>> node. By removing it, you will reduce the size of the data and have a
>> much mode accurate representation of the reality.
>>
>> Using the clock tree to handle these nodes was a hack we had to do
>> because the hwmod fmwk was not ready when OMAP4 was introduced and
>> because most drivers were not using pm_runtime.
>>
>
> Benoit,
>
> I completely understand what are trying to explain here, and I completely agree with you on the fact that, MODULEMODE_SWCTRL is for module control and is clock node is just a duplication.
>
> Module enable and disable is one part, and I am not at all referring to this.
> My point is, more from other piece of code which are dependent on clocktree.
> In order to have proper and complete debugfs representation of all the
> clocks, somebody has to maintain the information of leaf clocks to parent
> relation, Isn't it?

Nope, not at all. All the clocks will stay in the clock tree. The clock 
consumers a.k.a hwmods does not have to be in the clock tree.
Having some fake leaf nodes in the clock tree is just adding some fake 
intermediate clocks instead of the real consumer. These nodes do not 
exist, they were added to have a point of control from the driver before 
runtime_pm was there.

> For example, take OMAP44xx "dss_dss_clk" clock, OR any clock with "followparent_recalc" field, the question I am raising here is,

Then it is not an issue. If this is a real clock, it will then stay in 
the clock data.

> How would I know the rate of this clock in driver? Say for example, I want
> to configure my internal divider based on input rate?
> OR
> I want to change the rate of dss_clk itself?
> OR
> Looking at debugfs, would I get the rate of dss_clk?

No because that clock will not exist anymore, but you will have the real 
clock rate from the "dss_dss_clk".

> OR
> Will I have dss_clk present in /debug/clock/?
> OR
> Are we expecting user to know parent of such leaf clocks?

Yes, because it is not leaf nodes anymore, but modules.

> OR
> Are we planning to export hwmod->main_clk (which is parent clk here) to
> User in debugfs or something?

Well, I used to have a patch do expose hwmod to debugfs, but this is not 
that useful.

I think this is a non-issue, we are just removing clock nodes that are 
not real nodes, so it will not change anything practically speaking.

Regards,
Benoit

