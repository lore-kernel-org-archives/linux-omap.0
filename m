From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Date: Mon, 16 Jul 2018 17:43:03 +0530
Message-ID: <84a960a1-efac-ffcd-cf04-25b65922fd50@ti.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
 <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
 <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
 <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
 <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
 <3b53a8a7-3f3a-4341-35b0-e7b52854fa9b@ti.com>
 <20180716121005.GA23309@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716121005.GA23309@kroah.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, netdev@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ladislav Michl <ladis@linux-mips.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Lukas Wunner <lukas@wunner.de>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, "David
 S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Monday 16 July 2018 05:40 PM, Greg Kroah-Hartman wrote:
> On Mon, Jul 16, 2018 at 05:27:00PM +0530, Sekhar Nori wrote:
>> On Monday 16 July 2018 02:26 PM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 16/07/18 09:50, Sekhar Nori wrote:
>>>> On Friday 13 July 2018 11:30 PM, Bartosz Golaszewski wrote:
>>>>
>>>>> We're getting close to rc5 so I'd like to make a case for this series
>>>>> again.
>>>>>
>>>>> I understand that there's more to do than just the changes introduced
>>>>> here, but we shouldn't try to fix several problems in many different
>>>>> places at once. There's just too many moving pieces. I'd rather start
>>>>> merging small improvements right away.
>>>>>
>>>>> The idea behind this series is to remove (almost) all users of
>>>>> at24_platform_data. The davinci_emac patches are there only because we
>>>>> need to remove some MAC adress reading stuff from the board files.
>>>>> Having this code there and calling it back from EEPROM/MTD drivers is
>>>>> already wrong and we should work towards using nvmem for that anyway.
>>>>>
>>>>> Currently for MTD the nvmem support series seems to be dead and it's
>>>>> going to take some time before anything gets upstream.
>>>>>
>>>>> So I'd like to again ask you to consider picking up the patches from
>>>>> this series to your respective trees or at the very least: I'd like to
>>>>> ask Srinivas to pick up the nvmem patches and Sekhar to take the
>>>>> first, non-controversial batch of davinci platform changes so that
>>>>> we'll have less code to carry for the next release.
>>>>
>>>> I think those are patches 3-7. I can take those if I get an immutable
>>>> commit over v4.18-rc1 from Srinivas with patches 1 & 2 applied.
>>
>>> nvmem patches go via Greg KH char-misc tree, if it makes things easy I
>>> can provide Ack on nvmem patches, so that you can take these patches via
>>> your tree?
>>>
>>> Let me know.
>>
>> I can do that.
>>
>> Greg, are you fine with this? It will be great to have your ack for
>> patches 1/8 and 2/18.
> 
> I'm not the nvmem maintainer :)

Got it. Will apply with Srinivas's ack.

Regards,
Sekhar
