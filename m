From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Add pinctrl-single,bits type
 of mux
Date: Thu, 13 Sep 2012 08:52:36 +0200
Message-ID: <CACRpkdZjd5FANymXQOuz0nH+d_r6O6GdXrcnZObhq6mZ9cmH7A@mail.gmail.com>
References: <1347353664-15906-1-git-send-email-peter.ujfalusi@ti.com>
	<20120912202700.GD5997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120912202700.GD5997@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 12, 2012 at 10:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120911 01:54]:
>> With pinctrl-single,bits it is possible to update just part of the register
>> within the pinctrl-single,function-mask area.
>> This is useful when one register configures mmore than one pin's mux.
>
>>       size /= sizeof(*mux);   /* Number of elements in array */
>> -     rows = size / 2;        /* Each row is a key value pair */
>> +     rows = size / params;   /* Each row is a key value pair */
>
> Maybe just remove the comment:  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> I don't think it's needed any longer. Other than that,
> thanks for updating the patch:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied minus the comment, plus Tony's ACK, thanks!

Linus Walleij
