From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
Date: Fri, 29 Nov 2013 20:59:07 +0200
Message-ID: <5298E3FB.4010908@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <52969313.6090207@ti.com> <alpine.DEB.2.02.1311281857100.23429@utopia.booyaka.com> <20131129171256.GN31534@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42663 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab3K2S7l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Nov 2013 13:59:41 -0500
In-Reply-To: <20131129171256.GN31534@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/29/2013 07:12 PM, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [131128 10:59]:
>> On Wed, 27 Nov 2013, Nishanth Menon wrote:
>>
>>> http://pastebin.mozilla.org/3681900 -> AM3517-evm (not sure yet how
>>> long this has been broken).
>>
>> Seems to work in v3.13-rc1:
>>
>> http://www.pwsan.com/omap/testlogs/test_v3.13-rc1/20131124230250/boot/3517evm/3517evm_log.txt
>
> FYI, not really related to the clock patches, but we're also missing the .dtsi
> file for 3517 currently for the device tree based booting. I'm planning to take
> a look at that next week.

Yea I would guess this prevents this set from working also on that board. :)

-Tero
