From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCHv4 2/4] regulator: omap smps regulator driver
Date: Tue, 23 Aug 2011 08:28:13 +0100
Message-ID: <4E53568D.1040908@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>	<1311853739-18984-3-git-send-email-t-kristo@ti.com>	<20110729094853.GC13218@opensource.wolfsonmicro.com>	<87wrersley.fsf@ti.com> <4E3F9E24.1040808@ti.com> <87ty99gjga.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35227 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab1HWH2Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2011 03:28:25 -0400
In-Reply-To: <87ty99gjga.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Graeme Gregory <gg@slimlogic.co.uk>

On 22/08/11 23:39, Hilman, Kevin wrote:
> Liam Girdwood <lrg@ti.com> writes:
> 
>> On 05/08/11 20:33, Hilman, Kevin wrote:
>>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>>>
>>>> On Thu, Jul 28, 2011 at 02:48:57PM +0300, Tero Kristo wrote:
>>>>> OMAP SMPS regulator driver provides access to OMAP voltage processor
>>>>> controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
>>>>> additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
>>>>> layer for the actual voltage regulation operations.
>>>>>
>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>>
>>> Do you prefer we merge this via OMAP trees (along with the
>>> infrastructure) or would you like to merge it.
>>>
>>> At this point, it's probably best to merge it along with the voltage
>>> infrastructure, which still might change slightly at the API level.
>>>
>>
>> Ok, lets merge with the voltage infrastructure.
>>
> 
> OK, shall I take this is an Ack from you then?
> 
> Kevin

Sorry, yes.

Acked-by: Liam Girdwood <lrg@ti.com>
