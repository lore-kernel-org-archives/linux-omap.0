From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Wed, 25 Apr 2012 10:40:49 +0200
Message-ID: <4F97B891.1020601@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46079 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab2DYIk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 04:40:56 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On 4/25/2012 7:48 AM, Hiremath, Vaibhav wrote:
> On Wed, Apr 25, 2012 at 06:33:26, Paul Walmsley wrote:
>> Hello Vaibhav, Afzal, Vaibhav,
>>
>> On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:
>>
>>> AM33XX clock implementation is different than any existing OMAP
>>> family of devices. Although DPLL module is similar to OMAP4
>>> device, but the usage is very much different than OMAP4.
>>> AM33XX has different peripheral set and each module gets
>>> integrated to the clock framework differently than OMAP
>>> family of devices.
>>>
>>> This patch adds full Clock tree data for AM33XX family
>>> of devices and also integrates it into existing OMAP framework.
>>
>> What do you think about the possibility of removing all of the leaf =
clocks
>> that have AM33XX_MODULEMODE_SWCTRL as their .enable_bit, assuming th=
ere
>> are no .fixed_div or .clksel* fields associated with the clocks?
>>
>> In theory, I don't think they are needed.  The drivers should be usi=
ng
>> runtime PM, and that should enable and disable the module via the hw=
mod
>> code, rather than the clock code.
>>
>> Of course some clocks would still be needed for the main_clk fields =
for
>> the hwmods, but the hwmods should be able to use the leaf clock's pa=
rent
>> clocks for that.
>>
>> That would save quite a few lines of data.  And I think Beno=EEt is =
planning
>> to do that for OMAP4+.
>>
>> What do you think?
>>
>
> Paul,
>
> Yes, theoretically it is possible to do it. But it will also break so=
me of
> the existing things, like,
>
> 1. DebugFS clock interface
>
> I believe, with this change, you will not have all the leaf nodes as =
part of clock tree, so they will not be populated in /debug/clock/
>
> 2. Enable and disable of the module is one part, but what about, chan=
ging
>     the rate of the clock (followparent_recalc)?
>     With the proper and complete clock tree, you can traverse the clo=
ck and
>     driver code doesn't need to know about parent.
>     Driver can simply call clk_set_rate() on leaf clock, and clock tr=
ee will
>     handle it.
>
> If at all we take this path, we have to build the clk node runtime
> (on-the-fly), AND/OR add new pm_runtime_set_rate() api.

Not at all. You just have to get the fck of that hwmod and use the cloc=
k=20
API.

> Are you available on IRC chat anytime? We can discuss on this and ali=
gn
> quickly.
> I am available on linux-omap irc channel (with the name =3D "hvaibhav=
")

That will not change anything, the point is that MODULEMODE_SWCTRL is=20
uses for module control, not for clock directly, and that's why it is=20
handled by the hwmod.

That will just replace the main_clk from the hwmod with the parent of=20
the current modulemode nodes. Only the enable/disable part will be=20
handled, if that node used to have a div, then the parent will handle t=
hat.

Today this module mode clock node is just a duplication of the hwmod=20
node. By removing it, you will reduce the size of the data and have a=20
much mode accurate representation of the reality.

Using the clock tree to handle these nodes was a hack we had to do=20
because the hwmod fmwk was not ready when OMAP4 was introduced and=20
because most drivers were not using pm_runtime.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
