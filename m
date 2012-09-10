From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: pinctrl-single: Add pinctrl-single,bits
 type of mux
Date: Mon, 10 Sep 2012 11:49:55 -0700
Message-ID: <20120910184955.GB1303@atomide.com>
References: <1346835718-21325-1-git-send-email-peter.ujfalusi@ti.com>
 <1346835718-21325-3-git-send-email-peter.ujfalusi@ti.com>
 <CACRpkdbiCV4sKy2JAb6Yu5EuOVbfhq46yu5FRy7MXNT3QR6gaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbiCV4sKy2JAb6Yu5EuOVbfhq46yu5FRy7MXNT3QR6gaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [120910 00:11]:
> On Wed, Sep 5, 2012 at 11:01 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> > With pinctrl-single,bits it is possible to update just part of the register
> > within the pinctrl-single,function-mask area.
> > This is useful when one register configures mmore than one pin's mux.
> >
> > pinctrl-single,bits takes three parameters:
> > <reg offset, value, sub-mask>
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Do we have a conclusion on this patch 2/2?
> 
> I'm holding it back until Tony explicitly ACKs it for now.

I don't like the idea of mixing different types of controllers
here, so let's wait a little bit on 2/2.

Tony
