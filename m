From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Mon, 19 Dec 2011 11:47:18 +0530
Message-ID: <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
 <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com> <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49093 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793Ab1LSGRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 01:17:42 -0500
Received: by qcse1 with SMTP id e1so3268947qcs.11
        for <linux-omap@vger.kernel.org>; Sun, 18 Dec 2011 22:17:41 -0800 (PST)
In-Reply-To: <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, Dec 16, 2011 at 10:03 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Sat, Dec 17, 2011 at 12:09 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> No. The table reflects the actual possible combination on hardware. You can't
>> add anything there arbitrary if that combination is not supported.
>>
>> But that makes me wonder how the patch worked. I will look at this in detail
>> next week.
>
> Thanks, I use the below hwmod data patch[1] and omap device patch[2]
> to bring up fdif module, and Benoit has ACKed on patch [1].
>
>
> [1], http://marc.info/?l=linux-kernel&m=132387140703874&w=2
> [2], http://marc.info/?l=linux-kernel&m=132387155403929&w=2
>
The patches are fine but I am surprised that 'dyndep.patch' is helping you.
L3_2 dependency is always enabled with ISS or Camera and it
should have worked.
clkdm_add_wkdep(iss_clkdm, l3_2_clkdm), shoudn't do anything since
the bit is read-only.

Can you check value of CM_CAM_STATICDEP [ 0x4A009004],
after your patch. I am suspecting that for some reason l3_1 dep.
is getting enabled which might be helping your case.

Regards
Santosh
