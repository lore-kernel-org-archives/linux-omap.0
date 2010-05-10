From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Subject: Re: [PATCHv4 0/2] omap-sham: OMAP SHA1/MD5 driver
Date: Mon, 10 May 2010 14:40:53 +0300
Message-ID: <4BE7F0C5.6040904@nokia.com>
References: <cover.1272464135.git.dmitry.kasatkin@nokia.com> <20100503031139.GA31376@gondor.apana.org.au> <20100505183849.GB29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20100505183849.GB29604@atomide.com>
Sender: linux-crypto-owner@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Hmm.. yes. in my first patch I had OMAP3 and 2
Should I send updated patch above that?

- Dmitry


On 05/05/10 21:38, ext Tony Lindgren wrote:
> * Herbert Xu <herbert@gondor.apana.org.au> [100502 20:07]:
>   
>> On Wed, Apr 28, 2010 at 05:18:05PM +0300, Dmitry Kasatkin wrote:
>>     
>>> Changes to v4:
>>> - concurrent requests support via queue
>>> - hmac
>>> - shash support removed
>>>
>>> Dmitry Kasatkin (2):
>>>   crypto: updates omap sham device related platform code
>>>   crypto: omap-sham - omap sha1 & md5 driver
>>>       
>> Both patches applied.  Thanks for all your hard work Dmitry!
>>     
> Just noticed that the first patch should be updated:
>
> CONFIG_ARCH_OMAP2 instead of CONFIG_ARCH_OMAP24XX
> CONFIG_ARCH_OMAP3 instead of CONFIG_ARCH_OMAP34XX
>
> BTW, chances are that this part will conflict with other
> omap patches. But if that happens, we can move it to
> the omap for-next.
>
> Regards,
>
> Tony
>   
