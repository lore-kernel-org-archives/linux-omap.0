From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Add pinctrl-single,bits type
 of mux
Date: Thu, 13 Sep 2012 10:36:24 +0300
Message-ID: <50518CF8.2050106@ti.com>
References: <1347353664-15906-1-git-send-email-peter.ujfalusi@ti.com> <20120912202700.GD5997@atomide.com> <CACRpkdZjd5FANymXQOuz0nH+d_r6O6GdXrcnZObhq6mZ9cmH7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZjd5FANymXQOuz0nH+d_r6O6GdXrcnZObhq6mZ9cmH7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/13/2012 09:52 AM, Linus Walleij wrote:
> On Wed, Sep 12, 2012 at 10:27 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120911 01:54]:
>>> With pinctrl-single,bits it is possible to update just part of the =
register
>>> within the pinctrl-single,function-mask area.
>>> This is useful when one register configures mmore than one pin's mu=
x.
>>
>>>       size /=3D sizeof(*mux);   /* Number of elements in array */
>>> -     rows =3D size / 2;        /* Each row is a key value pair */
>>> +     rows =3D size / params;   /* Each row is a key value pair */
>>
>> Maybe just remove the comment:  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> I don't think it's needed any longer. Other than that,
>> thanks for updating the patch:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> Applied minus the comment, plus Tony's ACK, thanks!

Thank you Linus, I was about to send the v3 with the removed comment.

--=20
P=E9ter
