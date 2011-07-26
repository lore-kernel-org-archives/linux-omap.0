From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4460: Hwmod: Add hwmod for thermal sensor
Date: Tue, 26 Jul 2011 10:46:56 +0200
Message-ID: <4E2E7F00.4080805@ti.com>
References: <1309877932-27202-1-git-send-email-vishwanath.bs@ti.com>	<alpine.DEB.2.00.1107070328150.30028@utopia.booyaka.com> <CAJ6a13brXSxeK82wg86x9gS4=UMAXJaXnR9hPwLzGJrBvh9AOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab1GZIrA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jul 2011 04:47:00 -0400
In-Reply-To: <CAJ6a13brXSxeK82wg86x9gS4=UMAXJaXnR9hPwLzGJrBvh9AOg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 7/21/2011 5:26 PM, J, KEERTHY wrote:
> On Thu, Jul 7, 2011 at 2:59 PM, Paul Walmsley<paul@pwsan.com>  wrote:
>> Hi
>>
>> On Tue, 5 Jul 2011, Vishwanath BS wrote:
>>
>>> From: Keerthy<j-keerthy@ti.com>
>>>
>>> Patch adds hwmod entry for 4460 thermal sensor module. Thermal sens=
or module
>>> is part of Control module sharing its address space and clocked via=
 Bandgap
>>> Functional Clock. Adding a seperate hwmod entry for thermal sensor =
will
>>> enable thermal sensor driver to manage its clock cleanly using PM r=
untime
>>> interfaces.
>>>
>>> Signed-off-by: Keerthy<j-keerthy@ti.com>
>>> Signed-off-by: Vishwnath BS<vishwanath.bs@ti.com>
>>
>> This needs to be coordinated with Beno=EEt, since he's the maintaine=
r of
>> this file.  Since he's away at the moment, this is probably 3.2 mate=
rial.
>>
>
> Hello Paul/Tony,
>
> This hwmod is specific to OMAP4460. When i tried to compile i see tha=
t
> CHIP_IS_OMAP446X is missing. Since this is very much specific to
> OMAP4460 is there another way to differentiate between OMAP4430 and
> OMAP4460?

That flag should be added by the OMAP4460 series Rajendra did.
This is still the right way to identify a chip for the moment.

Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
