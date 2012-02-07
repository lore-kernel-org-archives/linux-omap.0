From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: OMAP34xx
Date: Mon, 6 Feb 2012 21:35:15 -0700
Message-ID: <CACxGe6t0-10DOwrh_auvUtOUZ3SCgiz8vFrf35LejT+Py8q0zA@mail.gmail.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com> <20120207002405.GA18209@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:43777 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756354Ab2BGEfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 23:35:36 -0500
Received: by obcva7 with SMTP id va7so7767826obc.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Feb 2012 20:35:35 -0800 (PST)
In-Reply-To: <20120207002405.GA18209@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On Mon, Feb 6, 2012 at 5:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
>> In theory that patch should not be even needed.
>
> In theory that change is needed to fix the obviously broken code which
> is there at the moment.
>
> So, irrespective of whether OF gets permanently enabled or not, that ifdef
> needs to go.
>
> But, forcing OF on at this point probably isn't a good idea (who knows
> what else is lurking there) and there's a fairly simple and tested fix
> for this as I've shown in my OMAP patch.
>
> That, I feel, is likely to have less side effects than force enabling
> USE_OF.

+1.  Fix the obvious bug in 3.3.  In 3.4 this hunk of code is going to
be replaced anyway.

g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
