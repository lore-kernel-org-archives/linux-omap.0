From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 1/3] misc: Add crossbar driver
Date: Fri, 23 Aug 2013 11:41:24 +0530
Message-ID: <5216FD0C.3090709@ti.com>
References: <51E83A4F.5080904@ti.com> <CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com> <51ED2385.60108@ti.com> <51ED5C66.1010407@ti.com> <51EFFBE1.4090505@ti.com> <51F0031B.1050307@ti.com> <51F00530.9090703@ti.com> <51F02069.3050207@ti.com> <51F0223E.4050008@ti.com> <51F0240F.3050507@ti.com> <20130813081003.GU7656@atomide.com> <520A02BA.4090805@ti.com> <CACRpkda+m82PYJsExLM6JLsLa8-bVhdvy_r_+-uKfVT2NG7Cbg@mail.gmail.com> <520D398D.9040806@ti.com> <CACRpkdYeo1y-HhftkRWgwyq8o-NVuJ978Uq+ON880LHhUxC=hg@mail.gmail.com> <520D44C5.6080205@ti.com> <CACRpkdagSHxzV3=427O9iftNxM+N=w9aPds=iDvGQPoG3H-cWw@mail.gmail.com> <5215F6F6.9060703@ti.com> <5216E966.5020902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5216E966.5020902@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

Hi,
On Friday 23 August 2013 10:17 AM, Rajendra Nayak wrote:
> On Thursday 22 August 2013 05:03 PM, Sricharan R wrote:
>>  maps crossbar number<->  to interrupt number and
>>  calls request_irq(int_no, crossbar_handler,..)
> So will this mapping happen based on some data passed from DT or
> just based on whats available when the device does a request_irq()?
>
> If its based on whats available then I see an issue when you need
> to remap something thats already mapped by default (and not used)
> since you run out of all free ones.
Yes, when done based on what is available then there is a
problem when we run out of free ones because we do not
know which one to replace. I was thinking of something like
this,
    1) DT would give a list of all free ones, and also if some are
        mapped as default and not used, mark those also as free.

     2) While mapping see if it has a default mapping and use it.
          otherwise, pick from free list.   

  This should be ok right ?

Regards,
 Sricharan

