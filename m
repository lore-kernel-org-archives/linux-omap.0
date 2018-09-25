From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
Date: Tue, 25 Sep 2018 16:19:50 -0500
Message-ID: <b1990cde-9b12-58e0-7181-5085234c0a8a@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-4-dmurphy@ti.com> <20180924161844.GA29028@bogus>
 <20180924180219.GA24418@amd>
 <CAL_JsqLsKtzvnkfwy4H7QQyRqwEEmSp_qi_28=QoLJqs0w2NNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLsKtzvnkfwy4H7QQyRqwEEmSp_qi_28=QoLJqs0w2NNw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Rob/Pavel/Jacek

On 09/25/2018 02:39 PM, Rob Herring wrote:
> On Mon, Sep 24, 2018 at 1:02 PM Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Hi!
>>
>>>> Add the device tree bindings for the lm3697
>>>> LED driver for backlighting and display.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>
>>>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
>>>>  1 file changed, 86 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> We already have binding for lm3697 in
>> Documentation/devicetree/bindings/mfd/ti-lmu.txt . Is it good idea to
>> have second one?
> 
> Of course not. Now that you mention it, I do remember seeing some
> discussion on this.
> 
> Rob
> 

I will be posting a RFC tomorrow with all the changes that shows 3 devices
attached to the common code along with extending out the features on the LED
drivers themselves.

Its not complete or tested code but it should give a basis for discussion.  This way I
can do some other code while this is being discussed.

Dan

-- 
------------------
Dan Murphy
