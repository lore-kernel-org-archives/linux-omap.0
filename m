From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [RFC/PATCH 3/3] i2c: omap: Add support for I2C_M_STOP message flag
Date: Wed, 18 Jul 2012 17:38:36 +0530
Message-ID: <CAM=Q2cu866D4kbZMjTP4mTP4VhgyN1jGoTP-NFYMBBm2w25gzQ@mail.gmail.com>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1340720229-30356-4-git-send-email-laurent.pinchart@ideasonboard.com>
	<5006556C.8070003@ti.com>
	<223770735.y2EoxFmDTd@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52472 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab2GRMIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 08:08:37 -0400
In-Reply-To: <223770735.y2EoxFmDTd@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Wed, Jul 18, 2012 at 4:43 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Shubhrajyoti,
>
> On Wednesday 18 July 2012 11:49:24 Shubhrajyoti wrote:
>> On Tuesday 26 June 2012 07:47 PM, Laurent Pinchart wrote:
>> > Generate a stop condition after each message marked with I2C_M_STOP.
>> >
>> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> > ---
>> >
>> >  drivers/i2c/busses/i2c-omap.c |    2 ++
>> >  1 files changed, 2 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> > index 801df60..cf1bda0 100644
>> > --- a/drivers/i2c/busses/i2c-omap.c
>> > +++ b/drivers/i2c/busses/i2c-omap.c
>> > @@ -545,6 +545,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>> >
>> >     if (dev->speed > 400)
>> >
>> >             w |= OMAP_I2C_CON_OPMODE_HS;
>> >
>> > +   if (msg->flags & I2C_M_STOP)
>> > +           stop = 1;
>>
>> How about patching omap_i2c_xfer (caller) instead.
>> There are some debug prints of stop  above that will not reflect the
>> real value.
>
> omap_i2c_xfer() doesn't look at the content of individual messages, I thought
> it was cleaner not to modify that.

OK fair enough.
