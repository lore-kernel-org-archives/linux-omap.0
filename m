From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 09/10] crypto: omap-aes: gcm: Add support for PIO mode
Date: Thu, 2 Jul 2015 15:47:59 +0530
Message-ID: <55950FD7.8080803@ti.com>
References: <1435814320-30347-1-git-send-email-lokeshvutla@ti.com> <1435814320-30347-10-git-send-email-lokeshvutla@ti.com> <20150702080636.GH4033@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20150702080636.GH4033@saruman.tx.rr.com>
Sender: linux-crypto-owner@vger.kernel.org
To: balbi@ti.com
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Thursday 02 July 2015 01:36 PM, Felipe Balbi wrote:
> On Thu, Jul 02, 2015 at 10:48:39AM +0530, Lokesh Vutla wrote:
>> Add support for PIO mode for GCM mode.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> why do you require PIO ? Is there any situation where DMA can't be
> used? What would that case be ?

Cannot think of any case where DMA can't be used.
But the current driver already supports PIO for all other AES modes.
I do not want to break it, so added support for PIO  for GCM :)

Thanks and regards,
Lokesh
