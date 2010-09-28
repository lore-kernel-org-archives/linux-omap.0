From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v4] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Tue, 28 Sep 2010 15:26:43 +0400
Message-ID: <20100928112643.GC22734@oksana.dev.rtsoft.ru>
References: <1285618704-8985-1-git-send-email-notasas@gmail.com>
 <20100928060554.GF2702@legolas.emea.dhcp.ti.com>
 <AANLkTikZqtXa2YQsDehoWVMRstefUyafsQn2mph7U3CZ@mail.gmail.com>
 <20100928084251.GC3900@legolas.emea.dhcp.ti.com>
 <AANLkTin-6BLBHeiyA1edTJVjwVAimmJLVicZj8c_VC_2@mail.gmail.com>
 <20100928090637.GD3900@legolas.emea.dhcp.ti.com>
 <AANLkTim28RmH28LGgp6bEJ7XbyL4oO_5_C0phLL86roY@mail.gmail.com>
 <20100928094122.GA7081@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100928094122.GA7081@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Arun Murthy <arunrmurthy.83@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 28, 2010 at 12:41:22PM +0300, Felipe Balbi wrote:
> On Tue, Sep 28, 2010 at 04:39:17AM -0500, Grazvydas Ignotas wrote:
> >On Tue, Sep 28, 2010 at 12:06 PM, Felipe Balbi <balbi@ti.com> wrote:
> >>On Tue, Sep 28, 2010 at 04:02:48AM -0500, Grazvydas Ignotas wrote:
> >>>>
> >>>>Charger event is SENT by charger driver when it verifies it's attached
> >>>>to a wall charger.
> >>>
> >>>Isn't that a job for musb/gadget? Detecting D+/D- being shorted by
> >>>charger or something like that? I don't think BCI is able to detect
> >>>charger.
> >>
> >>it's part of the charger detection right ? and according to trm, it's on
> >>the BCI (actually BCC) role to take care of that :-)
> >
> >Hm you are probably talking about TWL5031, which has redesigned
> >charger block that is named BCC. TWL4030 charger is different, called
> >BCI and requires software charger detection from what I see in it's
> >TRM.
> 
> ok, might be that I got confused. Then it's ok the way it is. So we need
> other means to detect the charger :-p

May we consider this as a minor issue that can be improved later?

If so, I would like to apply it, but I'll wait a day or two for
Reviewed-by or Acked-by tags to give the proper credits.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
