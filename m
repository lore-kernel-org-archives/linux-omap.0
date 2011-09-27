From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/5 v11] arm: omap: usb: ehci and ohci hwmod structures for omap3
Date: Tue, 27 Sep 2011 17:38:51 +0300
Message-ID: <1317134331.3820.44.camel@sokoban>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com> <1316691479-1849-2-git-send-email-keshava_mgowda@ti.com> <1316691479-1849-3-git-send-email-keshava_mgowda@ti.com> <alpine.DEB.2.00.1109221115320.10719@utopia.booyaka.com> <CAP05o4+Zc2z6sBOX_rQeoDQ9PneypcLRCyBbaaB2m+ZjeXZnaw@mail.gmail.com> <alpine.DEB.2.00.1109240020510.22872@utopia.booyaka.com> <CAP05o4Lwk2uUz5ou84GQsrsBdjW-FEYP-55pBzH+a74hP4g1Dw@mail.gmail.com> <cbad72cea703d117067f7c628f7db806@mail.gmail.com> <1317127327.3820.31.camel@sokoban> <CAP05o4J75jGLTH8prOGD79Mte4DOg9ukgwe3V-KHFnB1Q-fi4w@mail.gmail.com> <20110927132453.GF19603@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20110927132453.GF19603@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Basak, Partha" <p-basak2@ti.com>, parthab@india.ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>, sameo@linux.intel.com, tony@atomide.com, "Hilman, Kevin" <khilman@ti.com>, johnstul@us.ibm.com, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2011-09-27 at 15:24 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Tue, Sep 27, 2011 at 06:48:35PM +0530, Munegowda, Keshava wrote:
> > > So, you would need a mechanism to do something like this:
> > >
> > > pad a or b wakeup detected -> irq0
> > > pad c or d wakeup detected -> irq1?
> > 
> > yes, if get something like this , its perfect.
> 
> can't you have different IRQs for each pad ? I mean, allocate one
> irq_desc for each pad and let drivers request a pad/pin as an IRQ
> source. Then, when you detect a pad wakeup, you can:

Direct pad to irq mapping was turned down on some previous version of
the prcm chain handler set, but yes, it is a potential approach. However
the irq_desc allocation mechanism should be dynamic... there are some
200 programmable pads anyway.

>
> unsigned	pad_irq = pad_number - pad->irq_base;
> 
> handle_nested_thread(pad_irq);
> 
> this will make use of threaded IRQ handlers even. Could it be something
> like that ?
> 



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 
