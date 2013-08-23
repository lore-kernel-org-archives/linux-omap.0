From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
Date: Fri, 23 Aug 2013 11:53:50 -0500
Message-ID: <5217939E.40903@ti.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.02.1308210012420.6426@utopia.booyaka.com> <5214C11F.8090808@baylibre.com> <5214C372.3080402@baylibre.com> <52158A7E.30305@ti.com> <5215CCFE.6040500@baylibre.com> <20130822212402.GA30504@animalcreek.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34361 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761Ab3HWQyg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Aug 2013 12:54:36 -0400
In-Reply-To: <20130822212402.GA30504@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Lokesh Vutla <lokeshvutla@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/22/2013 04:24 PM, Mark A. Greer wrote:
> On Thu, Aug 22, 2013 at 10:34:06AM +0200, Benoit Cousson wrote:
>> Hi Lokesh,
>>
>> On 22/08/2013 05:50, Lokesh Vutla wrote:
>>> Hi Benoit,
>>> On Wednesday 21 August 2013 07:11 PM, Benoit Cousson wrote:
>>>> Hi Mark,
>>>>
>>>> In fact I cannot even apply these patches since they are referring the the edma controller node that does not seem to be there in 3.11-rc6.
>>>>
>>>> Is this EDMA series supposed to be merged for 3.12? If this is the case, where can I find a reference GIT for it?
>>> The following EDMA support dt patch series from Joel is needed :
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92176.html
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92177.html
>>
>> Thanks, it works a little bit better with these patches :-)
> 
> Yeah, sorry.
> 
> Given Mark Rutland's comments in another email, let me respin and send v3.
> I'll put a comment about the dependencies this time.

Just sanity tested these patches on v3.11-rc6 too.

Drivers register successfully after passing the boot crypto testmgr tests.

bash-4.2# cat /proc/crypto | grep -i omap
driver       : ctr-aes-omap
driver       : cbc-aes-omap
driver       : ecb-aes-omap
driver       : omap-hmac-sha256
driver       : omap-hmac-sha224
driver       : omap-sha256
driver       : omap-sha224
driver       : omap-hmac-md5
driver       : omap-hmac-sha1
driver       : omap-md5
driver       : omap-sha1


Thanks,

-Joel
