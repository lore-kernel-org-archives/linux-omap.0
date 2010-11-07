From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 08/12] staging: tidspbridge: convert rmgr to list_head
Date: Sun, 07 Nov 2010 08:24:10 -0600
Message-ID: <4CD6B68A.5010107@ti.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>	 <1288969996-22103-9-git-send-email-ionut.nicu@mindbit.ro>	 <AANLkTinvM3W1WRNjw8zd=Yi6_J6uEw-h0efLjMrndCgn@mail.gmail.com>	 <1289067507.9931.95.camel@atlantis.mindbit.ro>	 <20101106182610.GA7306@kroah.com> <1289131884.9931.166.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38039 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752920Ab0KGOYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 09:24:20 -0500
Received: by gxk1 with SMTP id 1so3367005gxk.18
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 06:24:19 -0800 (PST)
In-Reply-To: <1289131884.9931.166.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Greg KH <greg@kroah.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, Ionut Nicu <ionut.nicu@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Ionut Nicu wrote, on 11/07/2010 06:11 AM:

> Just out of curiosity, in what cases is it acceptable to use
> BUG_ON/WARN_ON?
here is my rule for BUG_ON Vs WARN_ON:

imagine this code to be running on your Phone while you are doing 
sometime important, and this case gets hit - choose:
a) you stop the entire phone - BUG_ON
b) provide a cryptic info - WARN_ON - just the func name with not much 
additional data
c) provide detailed info : in the order of my personal preference:
	dev_dbg/dev_info/dev_err/... -> if there is anychange of getting to the 
struct device * representing the device
	pr_err/pr_info/pr_warning -> if there is no other alternative

keep in mind - few months from now, code would change, function line 
numbers change etc.. - I'd usually NOT TOUCH BUG_ON, NOT use WARN_ON 
unless I am threatened by maintainer, and choose one of (c) based on the 
location in the code I am at..

I know that some folks think that when a case is reached, they'd like to 
do a BUG_ON so that the issue is caught and fixed immediately - SORRY, I 
disagree as I see the code running in a endproduct - and BUG_ONs cause 
system hang and reboots in an end product - which as a personal user of 
a great Linux phone like N900 is definitely not my personal preference.

-- 
Regards,
Nishanth Menon
