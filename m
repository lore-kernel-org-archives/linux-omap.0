From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
Date: Tue, 14 Apr 2015 21:29:10 -0400
Message-ID: <20150415012910.GA29560@csclub.uwaterloo.ca>
References: <1425427237-11511-1-git-send-email-nm@ti.com>
 <1425427237-11511-2-git-send-email-nm@ti.com>
 <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com>
 <20150310153321.GO5264@atomide.com>
 <54FF28F5.4040707@ti.com>
 <20150310173115.GS5264@atomide.com>
 <54FF38F3.2030703@ti.com>
 <CACRpkdZ1faucps07jaT9kOyviC+Sw6gPkbF=cAGCUj+DiaEgTA@mail.gmail.com>
 <20150318014151.GL31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150318014151.GL31346@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 17, 2015 at 06:41:51PM -0700, Tony Lindgren wrote:
> Yeah agreed. I suggest discussing the binding and the generic
> parsing code for it first :)
>  
> It seems with the generic binding the actual driver should be
> just the hardware specific code hopefully.

Did this thread go anywhere in the last month?  I am certainly looking
forward to seeing what the resolution is to this, given for our use the
boot loader setup is not appealing at all.

-- 
Len Sorensen
