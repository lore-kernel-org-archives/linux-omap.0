From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/RFT PATCH 1/2] ARM: OMAP2+: hwmod-data: UART IP needs software
 control of sidle modes
Date: Fri, 15 Feb 2013 18:26:28 +0530
Message-ID: <511E307C.8010600@ti.com>
References: <1360930106-32005-1-git-send-email-santosh.shilimkar@ti.com> <20130215125055.GA16558@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161340Ab3BOMzX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 07:55:23 -0500
In-Reply-To: <20130215125055.GA16558@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Friday 15 February 2013 06:20 PM, Felipe Balbi wrote:
> On Fri, Feb 15, 2013 at 05:38:26PM +0530, Santosh Shilimkar wrote:
>> OMAP UART IP needs manual idle modes based on state of the
>> IP. Currently this is handled by the driver with function pointers
>> implemented in platform code.
>>
>> This however breaks in case of device tree because of missing
>> idle handling. With the provided flags, idle mode handling is transparently
>> handled by runtime time pm code.
>
> this last sentence can be improved a bit.
>
Indeed.

Regards,
Santosh
