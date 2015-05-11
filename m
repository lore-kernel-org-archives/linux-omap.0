From: Nishanth Menon <nm@ti.com>
Subject: Re: next-20150511 / omap2-mcspi: regression for sdp4430 boot
Date: Mon, 11 May 2015 13:27:08 -0500
Message-ID: <5550F47C.1030902@ti.com>
References: <5550DDCB.8010303@ti.com> <20150511170742.GA6616@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40467 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625AbbEKS1f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 14:27:35 -0400
In-Reply-To: <20150511170742.GA6616@deathray>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Mark Brown <broonie@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-spi@vger.kernel.org

On 05/11/2015 12:07 PM, Michael Welling wrote:
> On Mon, May 11, 2015 at 11:50:19AM -0500, Nishanth Menon wrote:
>> Hi,
>>
>> SDP4430 uses a SPI based network chip ks8851.
>>
>> next-20150508:
>> https://github.com/nmenon/kernel-test-logs/blob/next-20150508/omap2plus_defconfig/sdp4430.txt
>>
>> However, next-20150511:
>> https://github.com/nmenon/kernel-test-logs/blob/next-20150511/omap2plus_defconfig/sdp4430.txt
>>
> 
> I will look into this but it is going to be difficult to debug with access to the hardware.
> This is what I get for changing a driver that effects so many SoCs.
> 

Let me know if there is any test patch you'd want me to run. The board
is on a remote "board farm" which most of TI folks have access to as
well.. So, if you need anything run, just send out a debug patch OR a
potential fix and we can help try it out and provide logs back for
your debug.


-- 
Regards,
Nishanth Menon
