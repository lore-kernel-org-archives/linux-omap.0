From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: Re: [RESUBMIT][PATCH-v2][RFC] OMAP4: I2C Support for OMAP4430
Date: Tue, 18 Aug 2009 15:35:31 +0530 (IST)
Message-ID: <45002.192.168.10.88.1250589931.squirrel@dbdmail.itg.ti.com>
References: <54914.192.168.10.89.1248270620.squirrel@dbdmail.itg.ti.com>
    <58468.192.168.10.89.1248433802.squirrel@dbdmail.itg.ti.com>
    <20090729235150.GE8850@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41656 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbZHRKGF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Aug 2009 06:06:05 -0400
In-Reply-To: <20090729235150.GE8850@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben@fluff.org.uk>
Cc: ben-linux@fluff.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Ben,

> On Fri, Jul 24, 2009 at 04:40:02PM +0530, Syed Rafiuddin wrote:
>> Hi Ben,
>>
>> > This patch adds OMAP4 support to the I2C driver. All I2C register addresses  are different
>> between
>> > OMAP1/2/3 and OMAP4. In order to not have #ifdef's at  various places in code, as well as to
>> > support multi-OMAP build, Array's are  created to hold the register addresses.
>> >
>> > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
>> > ---
>>
>> No comment received on this patch,
>> Is there anything that I need to resolve?
>> Else can this patch get merged.
>
> sorry, been busy, will look at this in the next few days.

Seems like no issues with the patch since no comments received from long time.
Did you get a chance to look at the patch.Could you please merge this.

Regards,
Syed Rafiuddin


