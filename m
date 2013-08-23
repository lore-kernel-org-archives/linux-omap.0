From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] misc: Add crossbar driver
Date: Fri, 23 Aug 2013 15:44:46 -0400
Message-ID: <5217BBAE.2030703@ti.com>
References: <51E83A4F.5080904@ti.com>
 <CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com>
 <51ED2385.60108@ti.com> <51ED5C66.1010407@ti.com> <51EFFBE1.4090505@ti.com>
 <51F0031B.1050307@ti.com> <51F00530.9090703@ti.com> <51F02069.3050207@ti.com>
 <51F0223E.4050008@ti.com> <51F0240F.3050507@ti.com>
 <20130813081003.GU7656@atomide.com> <520A02BA.4090805@ti.com>
 <CACRpkda+m82PYJsExLM6JLsLa8-bVhdvy_r_+-uKfVT2NG7Cbg@mail.gmail.com>
 <520D398D.9040806@ti.com>
 <CACRpkdYeo1y-HhftkRWgwyq8o-NVuJ978Uq+ON880LHhUxC=hg@mail.gmail.com>
 <520D44C5.6080205@ti.com>
 <CACRpkdagSHxzV3=427O9iftNxM+N=w9aPds=iDvGQPoG3H-cWw@mail.gmail.com>
 <5215F6F6.9060703@ti.com> <5216E966.5020902@ti.com> <5216FD0C.3090709@ti.com>
 <521702E2.5000102@ti.com> <521706D9.9070001@ti.com> <521719D8.7060506@ti.com>
 <521765DC.2000609@ti.com> <52178D98.8020202@ti.com>
 <CACRpkdapqEVShaAekzr6TPW1U7d_y1=Gu6ixT6VS1=D1M-QjBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdapqEVShaAekzr6TPW1U7d_y1=Gu6ixT6VS1=D1M-QjBA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Sricharan R <r.sricharan@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Friday 23 August 2013 03:06 PM, Linus Walleij wrote:
> On Fri, Aug 23, 2013 at 6:28 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On 8/23/2013 7:08 PM, Santosh Shilimkar wrote:
> 
>>> The whole point we are moving to domain is not have any default
>>> mapping(connection done) at DT level. Rather DT only specifies the
>>> peripherals and their cross-bar connection ID(i.e cross-bar IRQ line).
>>> This will be the driver input as a IRQ line from DT. The cross-bar
>>> driver needs to map any of the free list available on *request* only.
>>
>> Right, the mapping can be done on request. That will be cleaner.
> 
> I like where this design is going now :-)
> 
Sure and thanks for good discussion. Debates are useful

regards,
Santosh
