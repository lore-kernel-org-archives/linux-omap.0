From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 1/6] mmc: host: omap_hsmmc: trivial cleanups
Date: Thu, 15 Mar 2012 19:56:10 +0530
Message-ID: <CANrkHUabAEQf4fkuxhY4UkckT1A5gXU2qOpeb5bqmw8YR10eRw@mail.gmail.com>
References: <1331716714-31912-1-git-send-email-balbi@ti.com>
	<CANrkHUYGDYiCrXp56fwgoXvOin_YPAnyQPhDiFWizZ2X0WM-Sw@mail.gmail.com>
	<20120315140048.GO28447@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:53573 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753958Ab2COO0L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 10:26:11 -0400
Received: by mail-lpp01m010-f42.google.com with SMTP id l5so5757905lah.1
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 07:26:10 -0700 (PDT)
In-Reply-To: <20120315140048.GO28447@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>, cjb@laptop.org

On Thu, Mar 15, 2012 at 7:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Mar 15, 2012 at 07:20:22PM +0530, T Krishnamoorthy, Balaji wr=
ote:
>> On Wed, Mar 14, 2012 at 2:48 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > a bunch of non-functional cleanups to the omap_hsmmc
>> > driver.
>> >
>> > It basically decreases indentation level, drop unneded
>> > dereferences and drop unneded accesses to the platform_device
>> > structure.
>> >
>> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > ---
>> > =A0drivers/mmc/host/omap_hsmmc.c | =A0147 ++++++++++++++++++++----=
-----------------
>> > =A01 file changed, 70 insertions(+), 77 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap=
_hsmmc.c
>> > index fd0c661..11fef49 100644
>> > --- a/drivers/mmc/host/omap_hsmmc.c
>> > +++ b/drivers/mmc/host/omap_hsmmc.c
>> > @@ -2104,30 +2104,28 @@ static int omap_hsmmc_remove(struct platfo=
rm_device *pdev)
>> > =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D platform_get_drvda=
ta(pdev);
>> > =A0 =A0 =A0 =A0struct resource *res;
>> >
>> > - =A0 =A0 =A0 if (host) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->dev);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_remove_host(host->mmc);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->use_reg)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_reg_put(h=
ost);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->pdata->cleanup)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->pdata->cleanup=
(&pdev->dev);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(host->irq, host);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_slot(host).card_detect_irq)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(mmc_slot(ho=
st).card_detect_irq, host);
>> > -
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(host->dev);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(host->dev);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->fclk);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->got_dbclk) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->db=
clk);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->dbclk)=
;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> Hi,
>>
>> Checking for host NULL is added in suspend/resume, however it is mis=
sing in
>> .remove, is it intentional ?
>
> you mean:
>
> if (!host)
> =A0 =A0 =A0 =A0return 0;
>
> ???
>
> That's intentional. We know platform_set_drvdata() is called on probe=
,
> and we can only reach .remove if .probe was called first. So we can m=
ake
> the assumption that dev->p->driver_data will always be valid on .remo=
ve.
> If it isn't, it's a bug on driver core which we want to catch ASAP, s=
o
> it deserves to oops.
>

Agreed.

> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
