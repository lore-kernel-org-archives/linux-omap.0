From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC] dt: export of_have_populated_dt
Date: Wed, 11 Apr 2012 09:46:17 +0530
Message-ID: <4F850591.3080209@ti.com>
References: <1334070672-11252-1-git-send-email-balajitk@ti.com> <4F845D99.7020705@ti.com> <87y5q3v9pd.fsf@laptop.org> <4F845FF9.5080005@ti.com> <4F846BDB.8020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38019 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871Ab2DKEQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 00:16:27 -0400
Received: by dajr28 with SMTP id r28so643191daj.40
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 21:16:26 -0700 (PDT)
In-Reply-To: <4F846BDB.8020805@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, bigeasy@linutronix.de

On Tuesday 10 April 2012 10:50 PM, Rob Herring wrote:
>> Rob,
>> >  Does it make sense to use that in the driver? So far I was using that
>> >  only in the arch code to make the difference between the DT boot and the
>> >  non-DT boot.
>> >
>> >  I guess that a driver should rely on of_match_device or non-NULL
>> >  device_node to figure out that?
>> >
> Agreed. of_match_device or device_node ptr check is the right approach.

Thanks Rob, I'll post a patch to fix that up.
