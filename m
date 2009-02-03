From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: MMC not working on 3430SDP
Date: Tue, 3 Feb 2009 14:44:50 +0200
Message-ID: <6ed0b2680902030444q51c58a52n2b3223fde82dab56@mail.gmail.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A3D45333@dbde02.ent.ti.com>
	 <00a301c985f1$9e5bf910$LocalHost@wipultra796>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:37300 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZBCMoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 07:44:54 -0500
Received: by fxm13 with SMTP id 13so2169681fxm.13
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 04:44:52 -0800 (PST)
In-Reply-To: <00a301c985f1$9e5bf910$LocalHost@wipultra796>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, Tony Lindgren <tony@atomide.com>, dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org

On Tue, Feb 3, 2009 at 1:21 PM, kishore kadiyala
<kishore.kadiyala@ti.com> wrote:
> Hi ,
>
> On 3430 SDP , the MMC card insertion and removal is not working on the linux
> -omap tree !
> It seems like interrupts are  not getting  triggered on Card insertion &
> removal !
>
> I wonder if it has to do something with GPIO library  !
> Also whether the GPIO library takes care of the requests to TWL4030 ?

If your board has TWL4030 you need to update the board file to
initialize .gpio_cd in twl4030_hsmmc_info structure (and send a patch
here, probably). For an example, see how it's done for beagle and
pandora.
