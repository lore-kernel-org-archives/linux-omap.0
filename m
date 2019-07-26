From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Backlight in motorola Droid 4
Date: Fri, 26 Jul 2019 09:38:57 -0500
Message-ID: <edde330e-516b-ecaa-4139-0bfa766a9c08@ti.com>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd> <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
 <20190724124530.GA30211@amd> <ca69f627-96e2-f982-3a29-18b0127ac6e5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ca69f627-96e2-f982-3a29-18b0127ac6e5@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 7/24/19 10:22 AM, Dan Murphy wrote:
> Pavel
>
> On 7/24/19 7:45 AM, Pavel Machek wrote:
> <snip>
>>
>> +
>>   static int lm3532_parse_node(struct lm3532_data *priv)
>>   {
>>       struct fwnode_handle *child = NULL;
>> @@ -536,11 +579,13 @@ static int lm3532_parse_node(struct lm3532_data 
>> *priv)
>>           ret = fwnode_property_read_u32(child, "ti,led-mode",
>>                              &led->mode);
>>           if (ret) {
>> +          /* FIXME: should just default to non-als mod */
>
> Looking at the rest of the code.
>
> The DT doc indicated that this was a required child property so this 
> is why it
>
> errors out.
>
> Dan
>
> <snip>
>

Did you want me to fix up the LM3532 and send the patch?

Or do you have a patch ready to go?

Dan
