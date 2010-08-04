From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 01/11] OMAP: DMA: Introduce DMA device attributes
Date: Wed, 04 Aug 2010 12:13:36 +0200
Message-ID: <4C593D50.4010908@ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com> <1280397545-27323-2-git-send-email-manjugk@ti.com> <4C5175A6.5020101@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402707515AE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47630 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271Ab0HDKNn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 06:13:43 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402707515AE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

On 7/30/2010 5:57 AM, G, Manjunath Kondaiah wrote:

<snip>

>>> +/* Attributes for OMAP DMA Contrllers */
>>> +#define ENABLE_1510_MODE		(1<<   0)
>>> +#define DMA_LINKED_LCH			(1<<   1)
>>> +#define GLOBAL_PRIORITY			(1<<   2)
>>> +#define RESERVE_CHANNEL			(1<<   3)
>>> +#define SRC_PORT			(2<<   3)
>>> +#define DST_PORT			(2<<   4)
>>> +#define IS_CSSA_32			(2<<   5)
>>> +#define IS_CDSA_32			(2<<   6)
>>> +#define SRC_INDEX			(4<<   6)
>>> +#define DST_INDEX			(4<<   7)
>>> +#define IS_BURST_ONLY4			(4<<   8)
>>> +#define CLEAR_CSR_ON_READ		(4<<   9)
>>> +#define IS_WORD_16			(8<<   9)
>>> +#define IS_RW_PRIORIY			(8<<   0xA)
>>
>> It is a minor detail, but why are you shifting both side of the
>> operator? It is really confusing, cannot you just do 1<<  X?
>> With 0<  X<  13.
> I can change this if it is confusing to others.

So you are still convince that this is a good way to do it???
What is the rational behind that?
Why adding potential source of confusion when you can avoid that easily?

Regards,
Benoit
