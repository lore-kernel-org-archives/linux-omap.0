From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 09/10] crypto: add timeout to crypto_wait_req
Date: Fri, 8 Nov 2019 09:40:57 +0200
Message-ID: <d55c0182-5fb0-2ef9-f056-54b396fb0026@ti.com>
References: <20191017122549.4634-1-t-kristo@ti.com>
 <20191017122549.4634-10-t-kristo@ti.com>
 <CAOtvUMeBXjDBhSVgMOW=hshEx_AkNPg-Zk2c2jCDzY8vyXWW5g@mail.gmail.com>
 <076f0bc6-ad04-9543-db02-d7c7060db036@ti.com>
 <CAOtvUMc7pbtPAPUbEmz_MTHmB9LboQVdgG-t9tHCr=biEbFuUQ@mail.gmail.com>
 <20191108022759.GB1140@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191108022759.GB1140@sol.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gilad Ben-Yossef <gilad@benyossef.com>, Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-omap@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/11/2019 04:27, Eric Biggers wrote:
> On Wed, Nov 06, 2019 at 09:33:20AM +0200, Gilad Ben-Yossef wrote:
>> On Wed, Nov 6, 2019 at 9:25 AM Tero Kristo <t-kristo@ti.com> wrote:
>>>
>>> On 06/11/2019 08:39, Gilad Ben-Yossef wrote:
>>>> Hi,
>>>>
>>>>
>>>> On Thu, Oct 17, 2019 at 3:26 PM Tero Kristo <t-kristo@ti.com> wrote:
>>>>>
>>>>> Currently crypto_wait_req waits indefinitely for an async crypto request
>>>>> to complete. This is bad as it can cause for example the crypto test
>>>>> manager to hang without any notification as to why it has happened.
>>>>> Instead of waiting indefinitely, add a 1 second timeout to the call,
>>>>> and provide a warning print if a timeout happens.
>>>>
>>>> While the incentive is clear and positive, this suggested solution
>>>> creates problems of its own.
>>>> In many (most?) cases where we are waiting here, we are waiting for a
>>>> DMA operation to finish from hardware.
>>>> Exiting while this pending DMA operation is not finished, even with a
>>>> proper error return value, is dangerous because
>>>> unless the calling code takes great care to not release the memory the
>>>> DMA is being done from/to, this can have disastrous effects.
>>>>
>>>> As Eric has already mentioned, one second might seem like a long time,
>>>> but we don't really know if it is enough.
>>>>
>>>> How about adding a second API (ig. crypto_wait_req_timeout) which
>>>> supports a calee specified timeout where
>>>> the calle knows how to correctly deal with timeout and port the
>>>> relevant call sites to use this?
>>>
>>> Yeah, that would work for me. I guess we could just swap the testmgr to
>>> use this timeout API, as it is quite clear it should timeout rather than
>>> wait indefinitely, and afaics, the data buffers it uses are limited
>>> size. It doesn't really matter for it whether the timeout is 1 second or
>>> 10 seconds, as long as it eventually times out.
>>
>>
>> As long as you avoid releasing the memory used on timeout, that should
>> work well, I think.
>>
> 
> The memory is always going to be freed eventually, though.  Although the crypto
> tests currently reuse the input/output buffers and the request structure from
> one test to the next, they're freed at the end of the tests.  Also, it's unsafe
> for one request structure to be used for multiple requests concurrently anyway.
> 
> I think crypto_wait_req_timeout() would just be fundamentally unsafe.
> 
> Couldn't you just use CONFIG_DETECT_HUNG_TASK=y instead?  It should report if
> any thread is blocked for too long.

The problem is not detecting a hung task, the problem is determining 
what caused the hang. Personally I don't care if the system dies if a 
crypto accelerator self test has failed, as long as I get reported about 
the exact nature of the failure. The failures are expected to happen 
only in development phase of a crypto driver.

With the timeout patch in place, I get reported what exact crypto test 
case failed and I can focus my debug efforts on that one.

Anyways, as said this is just a nice to have patch, and can be dropped 
no issues there. I was just thinking some other people might find it 
useful also.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
