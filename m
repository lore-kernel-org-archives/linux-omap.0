From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2 v3] OMAP-McSPI: Update platform McSPI files
Date: Fri, 13 Aug 2010 16:27:15 -0600
Message-ID: <AANLkTimxZmg6ze635eFVB7vAcOsjSjFTPeecyx+DWG1m@mail.gmail.com>
References: <65423.192.168.10.88.1281707926.squirrel@dbdmail.itg.ti.com> <AANLkTikGagiRWqnsGazt20U8dXjx-gkeY6rd6610mcT=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61333 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab0HMW1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 18:27:37 -0400
Received: by yxg6 with SMTP id 6so1142647yxg.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 15:27:36 -0700 (PDT)
In-Reply-To: <AANLkTikGagiRWqnsGazt20U8dXjx-gkeY6rd6610mcT=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, dbrownell@users.sourceforge.net, Hemanth V <hemanthv@ti.com>

On Fri, Aug 13, 2010 at 4:25 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Aug 13, 2010 at 7:58 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
>> + *
>> + * @fifo_depth when set to non zero values enables FIFO. fifo_depth
>> + * should be set as a multiple of buffer size used for read/write.
>> + */

Oh, and on this, which buffer size is being referred to?  The message
size, or something allocated internal to the bus driver?  The spi bus
driver will not have any foreknowledge of what buffer size is going to
be passed to it in spi messages.

g.
