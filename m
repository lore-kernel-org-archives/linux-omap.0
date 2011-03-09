From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Wed, 09 Mar 2011 08:28:45 -0800
Message-ID: <87zkp4dzr6.fsf@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>
	<4D775418.6050105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39141 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755047Ab1CIQ2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 11:28:55 -0500
Received: by mail-yx0-f172.google.com with SMTP id 30so418849yxk.17
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 08:28:51 -0800 (PST)
In-Reply-To: <4D775418.6050105@ti.com> (Rajendra Nayak's message of "Wed, 09
	Mar 2011 15:49:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

>> In terms of triage, does this patch fix something that currently doesn't
>> work (meaning that we should try to merge it for 2.6.39)?  Or can we plan
>> to merge this during the 2.6.40 time frame?  It would be ideal, of course,
>> if we could wait until 2.6.40, given how close we are to the merge window
>> opening.
>
> Since no clockdomains on OMAP4 were programmed in HW_AUTO untill now,
> we did not have any issues, but with the recent series from Santosh
> (which adds mpu ret/off support in idle/suspend) programming the
> clockdomains to HW_AUTO did show issues/aborts, and this patch
> fixes them.

FWIW, I was planning to merge the OMAP4 MPU ret/off series from Santosh
for 2.6.39, so this patch would be required for that to series to work.

Kevin
