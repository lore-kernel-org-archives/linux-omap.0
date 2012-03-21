From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 14:54:23 -0700
Message-ID: <873991d3hs.fsf@ti.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
	<4F69A872.50203@ti.com>
	<CAORVsuUeE046O7YJ_fE49NbW1OjZHZX+GuNiDkF0AnzBnSMbxA@mail.gmail.com>
	<4F6A04F3.6050306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45875 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759169Ab2CUVy1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 17:54:27 -0400
Received: by mail-pz0-f52.google.com with SMTP id p12so6816984dad.25
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 14:54:26 -0700 (PDT)
In-Reply-To: <4F6A04F3.6050306@linaro.org> (Daniel Lezcano's message of "Wed,
	21 Mar 2012 17:42:27 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linaro Dev <linaro-dev@lists.linaro.org>

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 03/21/2012 02:43 PM, Jean Pihet wrote:
>> On Wed, Mar 21, 2012 at 11:07 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com>  wrote:
>>> Daniel,
>>>
>>> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>>>> This patchset is a proposition to improve a bit the code.
>>>> The changes are code cleanup and does not change the behavior of the
>>>> driver itself.
>>>>
>>>> A couple a things call my intention. Why the cpuidle device is set for cpu0 only
>>>> and why the WFI is not used ?
>>>>
>>>> Daniel Lezcano (7):
>>>>    ARM: OMAP4: cpuidle - Remove unused valid field
>>>>    ARM: OMAP4: cpuidle - Declare the states with the driver declaration
>>>>    ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
>>>>    ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
>>>>    ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
>>>>    ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
>>>>    ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
>>>>      time
>>>>
>>> The series looks fine to me in general. This clean-up is applicable
>>> for OMAP3 cpuidle code as well.
>> Great!
>> However OMAP3 has a few specific things that cannot be removed as easily:
>> - the 'valid' flag is used because only certain combinations of power
>> domains states are possible,
>
> When I look the board-rx51 code I see:
>
> static struct cpuidle_params rx51_cpuidle_params[] = {
> 	/* C1 */
> 	{110 + 162, 5 , 1},
> 	/* C2 */
> 	{106 + 180, 309, 1},
> 	/* C3 */
> 	{107 + 410, 46057, 0},
> 	/* C4 */
> 	{121 + 3374, 46057, 0},
> 	/* C5 */
> 	{855 + 1146, 46057, 1},
> 	/* C6 */
> 	{7580 + 4134, 484329, 0},
> 	/* C7 */
> 	{7505 + 15274, 484329, 1},
> };
>
> If C3, C4, C6 are not valid, so AFAICS never used in the cpuidle code
> why the values are 'exit_latency' and 'target_residency' specified ? I
> mean why don't we have { 0, 0, 0 } ? Is it just for information ?

Yes, because getting those numbers were based on some board-specific
measurements, and we don't want those values to be lost.  Also, some
usage patterns might want to (re)enable those states.

> I understand the purpose of this code but it looks a bit tricky and
> hard to factor out. Is it acceptable to create a new cpuidle driver
> for rx51 then we factor out the code between omap3, omap4 and rx51
> when all the code consistent ?

I don't like that idea.  All the code is the same, the only thing we
need is the ability to pass in board-specific latency numbers for the
C-states.

These latency numbers are obviously quite significant when it comes to
the final power consumption, and these values often depend on
board-specific settings.  Until there are generic frameworks for
defining all the latencies involved, passing these values in from board
files is absolutly needed.

Kevin
