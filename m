From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/5] ARM: OMAP: Few device tree patches for 3.7
Date: Mon, 3 Sep 2012 22:24:09 -0700
Message-ID: <CAMQu2gwa8f8PYZ7T_tYATVfh9LRaH7seD+aCZS_btn5oW9HCTg@mail.gmail.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <5035DC7C.2000105@ti.com> <5044C6E3.10304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52202 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172Ab2IDFYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 01:24:31 -0400
Received: by obbwc20 with SMTP id wc20so29170437obb.1
        for <linux-omap@vger.kernel.org>; Mon, 03 Sep 2012 22:24:29 -0700 (PDT)
In-Reply-To: <5044C6E3.10304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com

On Mon, Sep 3, 2012 at 8:04 AM, Benoit Cousson <b-cousson@ti.com> wrote:
>
> Hi Santosh,
>
> Sorry for the delay, I missed that email :-(
>
> On 08/23/2012 09:32 AM, Santosh Shilimkar wrote:
> > Benoit,
> >
> > On Monday 13 August 2012 04:30 PM, Santosh Shilimkar wrote:
> >> These are the few device tree related patches which has been posted and
> >> reviewed on the list. They are intended for 3.7 merge window but I am
> >> posting them early enough to get into linux-next and linux-omap for
> >> testing.
> >>
> >> The following changes since commit
> >> 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
> >>
> >>    Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>    git://github.com/SantoshShilimkar/linux.git for_3.7/omap_dt
> >>
> >> for you to fetch changes up to
> >> bedee5fcb18062dfc933e0971e67fd6889c6446d:
> >>
> >>    ARM: OMAP4: Add local timer support for Device Tree (2012-08-13
> >> 11:59:26 +0530)
> >>
> >> ----------------------------------------------------------------
> >> Aneesh V (3):
> >>        dt: device tree bindings for LPDDR2 memories
> >>        dt: emif: device tree bindings for TI's EMIF sdram controller
> >>        ARM: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
> >>
> >> Santosh Shilimkar (2):
> >>        ARM: OMAP4: Add L2 Cache Controller in Device Tree
> >>        ARM: OMAP4: Add local timer support for Device Tree
> >>
> >
> > Will you pull this series from above git url or do you want me to send
> > a separate git pull request email ?
>
> I'll merge that branch on top of Sourav's and Peter's series and send
> the pull request to Tony.
>
Thanks Benoit.

Regards
Santosh
