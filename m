From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] mfd: lp873x: Add lp873x PMIC support
Date: Fri, 6 May 2016 09:38:08 +0530
Message-ID: <572C18A8.2060405@ti.com>
References: <1462425040-18566-1-git-send-email-j-keerthy@ti.com>
 <1462425040-18566-3-git-send-email-j-keerthy@ti.com>
 <CAKDJKT7AmeBkwH9=JpK49ADrogDqF1XCyHmZFiv4Ouwn-k9Y6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKDJKT7AmeBkwH9=JpK49ADrogDqF1XCyHmZFiv4Ouwn-k9Y6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org



On Thursday 05 May 2016 02:05 PM, Manish Badarkhe wrote:
> Hi Keerthy,
>
>> + * struct tps65086 - state holder for the tps65086 driver
>
> need to change name over here in comment.

Thanks for catching this Manish! I will fix it in the next version.

>
>> + * Device data may be used to access the LP873X chip
>> + */
>> +struct lp873x {
>> +       struct device *dev;
>> +       unsigned long id;
>> +       u8 rev;
>> +       struct mutex lp873_lock;        /* lock guarding the data structure */
>> +       struct regmap *regmap;
>> +};
>> +#endif /*  __LINUX_MFD_LP873X_H */
>> --
>
> Regards
> Manish Badarkhe
>
