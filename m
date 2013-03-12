From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2: twl-common: Add default power configuration
Date: Tue, 12 Mar 2013 09:57:05 -0700
Message-ID: <20130312165705.GA22059@atomide.com>
References: <1358967038-6615-1-git-send-email-matthias.bgg@gmail.com>
 <CAOCHtYjufr+MS1=6Cnsn-EgvkPs+Y5oWejAG98aLkVjdQbu1ZA@mail.gmail.com>
 <20130201224242.GE22517@atomide.com>
 <CABuKBe+NrMiX0nuEgwnHBqu-DqHST+uGG_Zyc7Ek=4WCOV1T6g@mail.gmail.com>
 <512355CF.6070605@ti.com>
 <CABuKBeLFfvCVyt9VhvwHVGuVGA7RDx9bZH_6gHk7yhfe-nmH5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:55884 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932153Ab3CLQ5O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 12:57:14 -0400
Content-Disposition: inline
In-Reply-To: <CABuKBeLFfvCVyt9VhvwHVGuVGA7RDx9bZH_6gHk7yhfe-nmH5A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "Kristo, Tero" <t-kristo@ti.com>, Robert Nelson <robertcnelson@gmail.com>, linux@arm.linux.org.uk, martinez.javier@gmail.com, eballetbo@iseebcn.com, ezequiel.garcia@free-electrons.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

* Matthias Brugger <matthias.bgg@gmail.com> [130308 11:02]:
> Hello Tony and Peter,
> 
> 2013/2/19 Peter Ujfalusi <peter.ujfalusi@ti.com>:
> > Hi Matthias,
> >
> > On 02/15/2013 04:59 PM, Matthias Brugger wrote:
> >> 2013/2/1 Tony Lindgren <tony@atomide.com>:
> >>> Hi,
> >>>
> >>> * Robert Nelson <robertcnelson@gmail.com> [130124 07:58]:
> >>>> On Wed, Jan 23, 2013 at 12:50 PM, Matthias Brugger
> >>>> <matthias.bgg@gmail.com> wrote:
> >>>>> This patch adds a generic power script configuration.
> >>>>> When rebooting an OMAP3530 at 125 MHz, the reboot hangs.
> >>>>> With the generic power script, TWL4030 will be reset
> >>>>> when a warm reset occures. This way the OMAP3530 does not
> >>>>> hang on reboot.
> >>>
> >>> Both look OK to me. I've added Peter to cc, it's best that he queues
> >>> all the twl changes.
> >>>
> >>
> >> Peter any comments on this patch?
> >
> > The patch looks good to me as well.
> 
> It looks like the patch wasn't added to the 3.9 series. Is there any
> reason for that, or was it just a misunderstanding between you two,
> about who will push it to Linus?

Sorry looks like this got missed. I suggest Peter collects the twl
patches and then provides me + mfd + asoc and whoever needs the
pull requests.

Regards,

Tony
