From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Subject: Re: [PATCHv3 2/2] crypto: omap-sham - omap sha1 & md5 driver
Date: Wed, 14 Apr 2010 09:38:58 +0300
Message-ID: <4BC56302.3060008@nokia.com>
References: <20100414062052.GA20395@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20100414062052.GA20395@gondor.apana.org.au>
Sender: linux-crypto-owner@vger.kernel.org
To: ext Herbert Xu <herbert@gondor.hengli.com.au>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I am thinking to update to have:
- concurrent requests with queue.
- import/export problem

but it takes a time.

- Dmitry


On 14/04/10 09:20, ext Herbert Xu wrote:
> Dmitry Kasatkin<dmitry.kasatkin@nokia.com>  wrote:
>    
>> Earlier kernel contained omap sha1 and md5 driver, which was not maintained,
>> was not ported to new crypto APIs and removed from the source tree.
>>
>> - implements async and sync crypto API using dma and cpu.
>> - supports multiple sham instances if available
>>
>> Signed-off-by: Dmitry Kasatkin<dmitry.kasatkin@nokia.com>
>>      
> You have not addressed my objections raised earlier.
>
> Also, why are you exporting a shash object? You cannot sleep during
> shash operations (except for setkey).
>
> Cheers,
>    
