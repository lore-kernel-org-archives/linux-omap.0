From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 0/5] ARM: dts: OMAP2+: use preprocessor for device
 trees
Date: Mon, 27 May 2013 13:14:52 +0200
Message-ID: <51A3402C.8090103@epfl.ch>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch> <519E3D16.2090003@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:49023 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757672Ab3E0LO6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 07:14:58 -0400
In-Reply-To: <519E3D16.2090003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello Santosh,

Thank you for your review.

On 05/23/2013 06:00 PM, Santosh Shilimkar wrote:
> On Thursday 23 May 2013 11:36 AM, Florian Vaussard wrote:
>> Hello,
>>
>> Following a similar proposal by Stephen Warren for tegra [1], this series
>> makes use of the C preprocessor when compiling OMAP DT files, and
>> accomplishes some improvements to improve overall readability.
>>
>> Patch 1 is a preparation for the rest of the series.
>> Patch 2 uses existing constants for GPIOs. Patch 3 does the same for
>> IRQs. Patch 4 creates a new header for OMAP's padmux, and patch 5 uses
>> it to simplify pinctrl DT.
>>
>> For all targets, the .dtb files were diff-tested before and after
>> applying the series to guarantee identity.
>>
>
>>
>> Florian Vaussard (5):
>>    ARM: dts: OMAP2+: use #include for all device trees
>>    ARM: dts: OMAP2+: use existing constants for GPIOs
>>    ARM: dts: OMAP4/5: use existing constants for IRQs
>>    ARM: dts: OMAP2+: header file for pinctrl constants
>>    ARM: dts: OMAP2+: use pinctrl constants
>>
> I just quickly scanned the series and patches looks
> good to my eyes. Its a nice clean-up to align OMAP
> dts files with others.
>
> FWIW,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>

I will send a v3 with minor changes to address Tony's comments, with
your Ack if ok for you.

Regards,

Florian
