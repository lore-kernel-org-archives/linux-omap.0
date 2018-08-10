From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
Date: Fri, 10 Aug 2018 13:42:26 +0530
Message-ID: <78917b7c-fb9b-2f88-1813-8cf951e60677@ti.com>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808155548.s7p4xqsjywz3psrj@ninjato>
 <CAMpxmJXVNiyqF4qaYtNhPUG3mSZVdvBSGUqDYK-nh59BKeh=Gw@mail.gmail.com>
 <20180808164402.GH7275@lunn.ch>
 <CAMRc=McfSZQvdXgrKDagb_TE1g-WzEhSpst1z_o5Z994cv3MjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMRc=McfSZQvdXgrKDagb_TE1g-WzEhSpst1z_o5Z994cv3MjA@mail.gmail.com>
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
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>
Cc: Wolfram Sang <wsa@the-dreams.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, linux-doc <linux-doc@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Sven Van Asbroeck <svendev@arcx.com>, Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Bart,

On Wednesday 08 August 2018 10:22 PM, Bartosz Golaszewski wrote:
> 2018-08-08 18:44 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> On Wed, Aug 08, 2018 at 06:27:25PM +0200, Bartosz Golaszewski wrote:
>>> 2018-08-08 17:55 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
>>>> On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> This is a follow-up to the previously rejected series[1] which partially
>>>>> removed the at24_platform_data structure. After further development and
>>>>> taking reviews into account, this series finally removes that struct
>>>>> completely but not without touching many different parts of the code
>>>>> base.
>>>>>
>>>>> Since I took over maintainership of the at24 driver I've been working
>>>>> towards removing at24_platform_data in favor for device properties.
>>>>
>>>> Wooha, nice work. I can't really comment on it but wondered how you want
>>>> to upstream it (after reviews)? Pull request of an immutable branch for
>>>> nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
>>>> it. Probably same situation for arm-soc...
>>>>
>>>
>>> I initially wanted to merge small parts of it starting with v4.18, but
>>> there were some voices against merging APIs without users. I'm not
>>> sure how it should go in. There'll be a need for multiple immutable
>>> branches most probably...
>>
>> Hi Bartosz
>>
>> What this series does is show all the different parts are now
>> available, and can be reviewed as a whole. Once that review is
>> completed, merging in parts then becomes possible.
>>
>> It looks like you could probably merge the nvmem, mtd and net parts
>> independently via there maintainers for 4.20, since i don't think
>> there are any dependencies. The arm-soc changes in 4.21, and the
>> removal of the platform data in 4.22?
>>
>>      Andrew
> 
> We need the first batch of SoC changes for the net part and then the
> second batch depends on those net changes. Also: dragging the merge
> for this over a year is a bit overkill.
> 
> Sekhar: I know you're usually provided with immutable branches from
> framework maintainers for the SoC changes - is it ok for you to
> provide the net maintainers with an immutable branch after applying
> the first part of davinci board file changes?

Yeah, sure. I will be happy to do that to speed merging. Will take a
look at v2 you posted.

Thanks,
Sekhar
