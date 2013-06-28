From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Fri, 28 Jun 2013 21:42:40 +0200
Message-ID: <51CDE730.7070608@amarulasolutions.com>
References: <51CC2755.2030505@amarulasolutions.com> <51CC454A.1040104@ti.com> <20130627141704.GF12956@panicking> <51CC5105.4070301@ti.com> <20130627175623.GB21364@panicking> <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com> <20130627192413.GA14115@panicking> <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com> <20130628113314.GA25536@panicking> <51CD7783.8030907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:49936 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3F1Tmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jun 2013 15:42:45 -0400
Received: by mail-ea0-f173.google.com with SMTP id g15so1239083eak.4
        for <linux-omap@vger.kernel.org>; Fri, 28 Jun 2013 12:42:44 -0700 (PDT)
In-Reply-To: <51CD7783.8030907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Hi

On 06/28/2013 01:46 PM, Roger Quadros wrote:
> On 06/28/2013 02:33 PM, Michael Trimarchi wrote:
>> Hi Roger
>>
>> On Thu, Jun 27, 2013 at 11:07:11PM +0300, Ruslan Bilovol wrote:
>>> On Thu, Jun 27, 2013 at 10:24 PM, Michael Trimarchi
>>> <michael@amarulasolutions.com> wrote:
> 
>>> Do you have locks around this software workaround?
>>> The patch I did against 3.4 linux kernel may be helpful for
>>> you in such case: http://review.omapzoom.org/28515
>>> Another patch extends this WA for all OMAP4 SoCs:
>>> http://review.omapzoom.org/31108
>>
>> I'm testing using pm_test and stop to core (5ms and not 5 seconds) (usb suspend cycle are done correctly) so
>> the problem could be:
>>
>> 1) SAR usb context restore. I have applied the SAR workaround but the core doesn't go in full retantion
>> could be it a problem?
> 
> If core doesn't go in to OFF then SAR will not come into play. Are you still affected by the
> issue if OFF mode is disabled? If yes then it probably is not related to SAR.
> 
>>
>> 2) idle status of ulpis pins?
> 
> Yes this can be possible.
> 
> When you said earlier that the problem doesn't happen when one of the ULPIs is used
> did you try both of them individually. e.g. case 1: port 1 only enabled,
> case 2: port 2 only enabled.
> 
> Did it work in both the cases?

off state of the line can make the situation worst ;). What are the idle/off state of the lines
on your platforms?

I can use PAD_REMUX flag to change the datax and signal of each port. I think that when the core
is in RET_OFF the signal lines are remuxed in off mode. Correct?

Michael


> 
> cheers,
> -roger
> 

