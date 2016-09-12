From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Mon, 12 Sep 2016 15:46:23 +0200
Message-ID: <CAALWOA98nPB9MRTmOnxWM3cePuAcxeMmyDRJ8hwo+zQh6HX+ug@mail.gmail.com>
References: <20160829223542.18871-1-tony@atomide.com> <57C74306.9020901@gmail.com>
 <20160831214151.wzq7y54xxs2qj422@atomide.com> <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
 <57D1B668.3070001@gmail.com> <CAL_JsqKYqQpDrLbV0DZ-CvHfeHsXvMc-gncc9obir4gehriXOw@mail.gmail.com>
 <20160909141055.GZ4990@bill-the-cat> <CAALWOA_kSghc91PGMTSE9MVbJm7SHjmVrcPfXwN_Fd+snYZdkg@mail.gmail.com>
 <20160912133510.GC13192@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160912133510.GC13192@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Frank Rowand <frowand.list@gmail.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 12 September 2016 at 15:35, Tom Rini <trini@konsulko.com> wrote:
> What do you mean by "you can't put it to good use" ?  Is that the case
> of stuff that's say exposed via a header and could be used but isn't (ie
> the cape/hat/chip/etc case) or the IP block is still OK but just not
> exposed at all?
>
> What we're trying to address here is the case of "don't even try to
> use the peripheral, bad things will happen.  But please properly idle
> the IP block!".

I'm pretty sure IP blocks in the "don't even try" category are
necessarily idled. There's no reason they wouldn't be.

The hwmod infrastructure generally tries to access the sysconfig
register located in the IP block address space itself. If you try to
do that with a peripheral that's efused out you'll get a bus error.

Matthijs
