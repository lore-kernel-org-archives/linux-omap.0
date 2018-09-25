From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
Date: Tue, 25 Sep 2018 14:39:28 -0500
Message-ID: <CAL_JsqLsKtzvnkfwy4H7QQyRqwEEmSp_qi_28=QoLJqs0w2NNw@mail.gmail.com>
References: <20180911170825.17789-1-dmurphy@ti.com> <20180911170825.17789-4-dmurphy@ti.com>
 <20180924161844.GA29028@bogus> <20180924180219.GA24418@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924180219.GA24418@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 24, 2018 at 1:02 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > Add the device tree bindings for the lm3697
> > > LED driver for backlighting and display.
> > >
> > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
>
> > >  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
> > >  1 file changed, 86 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> We already have binding for lm3697 in
> Documentation/devicetree/bindings/mfd/ti-lmu.txt . Is it good idea to
> have second one?

Of course not. Now that you mention it, I do remember seeing some
discussion on this.

Rob
