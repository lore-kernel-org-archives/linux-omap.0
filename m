From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/10] crypto: omap fixes towards 5.5
Date: Fri, 25 Oct 2019 15:18:06 +0300
Message-ID: <359434e9-3289-2982-edc1-b93e76c28700@ti.com>
References: <20191017122549.4634-1-t-kristo@ti.com>
 <CAKv+Gu_HNOTSvWRTzLMeECaM8qCi5w806ht_e68e5vgcU9aQvQ@mail.gmail.com>
 <8f97d690-a88a-55cb-eb67-206e01873d94@ti.com>
 <bf22f7dd-5446-d736-611b-6465df45b74d@ti.com>
 <CAKv+Gu_ABcosRm30nrtCY429Xki8_b9GAzQ=hQ=Kiuo2o6Y2ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu_ABcosRm30nrtCY429Xki8_b9GAzQ=hQ=Kiuo2o6Y2ng@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-omap@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-omap@vger.kernel.org

On 25/10/2019 15:05, Ard Biesheuvel wrote:
> On Fri, 25 Oct 2019 at 13:56, Tero Kristo <t-kristo@ti.com> wrote:
>>
>> On 25/10/2019 14:55, Tero Kristo wrote:
>>> On 25/10/2019 14:33, Ard Biesheuvel wrote:
>>>> On Thu, 17 Oct 2019 at 14:26, Tero Kristo <t-kristo@ti.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> This series fixes a number of bugs with omap crypto implementation.
>>>>> These have become evident with the changes to the cryptomanager, where
>>>>> it adds some new test cases and modifies some existing, namely the split
>>>>> update tests. Also, while fixing the cryptomanager induced bugs, some
>>>>> other surfaced with tcrypt/IPSec tests, so fixed them aswell.
>>>>>
>>>>> Patch #9 is against crypto core modifying the crypto_wait_req
>>>>> common API to have a timeout for it also, currently it waits forever
>>>>> and it is kind of difficult to see what test fails with crypto manager.
>>>>> This is not really needed for anything, but it is kind of nice to have
>>>>> (makes debugging easier.)
>>>>>
>>>>> This series has been tested on top of 5.4-rc2, with following setups,
>>>>> on AM57xx-beagle-x15 board:
>>>>>
>>>>> - crypto manager self tests
>>>>> - tcrypt performance test
>>>>> - ipsec test with strongswan
>>>>>
>>>>> This series depends on the skcipher API switch patch from Ard Biesheuvel
>>>>> [1].
>>>>>
>>>>
>>>> Hi Tero,
>>>>
>>>> On my BeagleBone White, I am hitting the following issues after
>>>> applying these patches:
>>>>
>>>> [    7.493903] alg: skcipher: ecb-aes-omap encryption unexpectedly
>>>> succeeded on test vector "random: len=531 klen=32";
>>>> expected_error=-22, cfg="random: inplace may_sleep use_finup
>>>> src_divs=[44.72%@+4028, <flush>14.70%@alignmask+3, 19.45%@+4070,
>>>> 21.13%@+2728]"
>>>> [    7.651103] alg: skcipher: cbc-aes-omap encryption unexpectedly
>>>> succeeded on test vector "random: len=1118 klen=32";
>>>> expected_error=-22, cfg="random: may_sleep use_final
>>>> src_divs=[<reimport>41.87%@+31, <flush>58.13%@+2510]"
>>>>
>>>> These are simply a result of the ECB and CBC implementations not
>>>> returning -EINVAL when the input is not a multiple of the block size.
>>>>
>>>> [    7.845527] alg: skcipher: blocksize for ctr-aes-omap (16) doesn't
>>>> match generic impl (1)
>>>>
>>>> This means cra_blocksize is not set to 1 as it should. If your driver
>>>> uses the skcipher walk API, it should set the walksize to
>>>> AES_BLOCK_SIZE to ensure that the input is handled correctly. If you
>>>> don't, then you can disregard that part.
>>>>
>>>> [    8.306491] alg: aead: gcm-aes-omap setauthsize unexpectedly
>>>> succeeded on test vector "random: alen=3 plen=31 authsize=6 klen=9";
>>>> expected_error=-22
>>>>
>>>> Another missing sanity check. GCM only permits certain authsizes.
>>>>
>>>> [    9.074703] omap_crypto_copy_sgs: Couldn't allocate pages for
>>>> unaligned cases.
>>>>
>>>> This is not a bug, but I'm not sure if the below is related or not.
>>>>
>>>> I'll preserve the binaries, in case you need me to objdump anything.
>>>
>>> What are these tests you are executing? For me, the testmgr self test
>>> suite is passing just fine. Any extra tests you have enabled somehow?
>>>
> 
> I enabled CONFIG_CRYPTO_MANAGER_EXTRA_TESTS, which enables a bunch of
> fuzz tests of the offloaded algorithms against the generic
> implementations.

Ahha I see, let me give that a shot locally. I have so far only been 
testing with the standard suite.

> 
>>> I am also running full test on different board though (am57xx), I
>>> haven't been explicitly running anything on am335x.
>>
>> Oh, and btw, did you try without my series? I think the selftests are
>> failing rather miserably without them...
>>
> 
> No, I just tried a branch with mine and your patches applied.

Could you give it a shot without the CRYPTO_MANAGER_EXTRA_TESTS, that 
should pass with my series, and fail without?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
