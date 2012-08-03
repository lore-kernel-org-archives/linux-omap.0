From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH 2/2] OMAP4: otg: phy: remove uggly mdelay(200)
Date: Fri, 3 Aug 2012 11:34:33 +0300
Message-ID: <CAEa47No+Krf8XPnZ+49JC-df_gtEWLm801rG64D=0wT7v4phaQ@mail.gmail.com>
References: <1341477739-6801-1-git-send-email-ruslan.bilovol@ti.com>
	<CAAe_U6K5n5SEBDR1vgaoc1+MQB=_aQ7yc0jBu1BFgX-D5ZPt8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:35323 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052Ab2HCIef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 04:34:35 -0400
Received: by yenl12 with SMTP id l12so473465yen.15
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 01:34:34 -0700 (PDT)
In-Reply-To: <CAAe_U6K5n5SEBDR1vgaoc1+MQB=_aQ7yc0jBu1BFgX-D5ZPt8w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi,


On Fri, Aug 3, 2012 at 9:51 AM, ABRAHAM, KISHON VIJAY <kishon@ti.com> wrote:
>
> Hi,
>
> On Thu, Jul 5, 2012 at 2:12 PM, Ruslan Bilovol <ruslan.bilovol@ti.com>
> wrote:
> > The original issue with powering on the PHY (and using
> > 200 ms delay after this) is not related to internal
> > processes in the PHY but is in the incorrect charger
> > detection feature usage.
> >
> > Now when it is fixed, we can safely remove this uggly
>
> So is this 200ms delay related to incorrect charger detection? How is
> it now fixed without the delay?

Please take a look at the first patch of this series:
http://markmail.org/message/vlbk7glkyviviipw
It fixes charger detection feature usage.

--
Best regards,
Ruslan Bilovol
