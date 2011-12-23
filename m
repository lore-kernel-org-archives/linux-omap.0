From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 23 Dec 2011 15:07:13 +0530
Message-ID: <CAMQu2gwhyZasccr8wU6srhb8Y+T02yawy+RQQMzUGZjy1bvtJA@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
 <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
 <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
 <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
 <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
 <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com> <4EF44363.4050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:37610 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756163Ab1LWJhf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 04:37:35 -0500
Received: by mail-qy0-f172.google.com with SMTP id f15so6776348qcs.17
        for <linux-omap@vger.kernel.org>; Fri, 23 Dec 2011 01:37:35 -0800 (PST)
In-Reply-To: <4EF44363.4050008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ming Lei <tom.leiming@gmail.com>, Miguel Vadillo <vadillo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@ti.com>

On Fri, Dec 23, 2011 at 2:31 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Santosh,
>
>
> On 12/23/2011 9:45 AM, Shilimkar, Santosh wrote:
>>
>> On Fri, Dec 23, 2011 at 2:00 PM, Ming Lei<tom.leiming@gmail.com> =A0=
wrote:
>
>
> [...]
>
>
>>> The only change on iss(CAM) clock domain setting in your commit[1] =
is to
>>> configure CLKTRCTRL as HW_AUTO, instead of previous =A0SW_WKUP.
>>> Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
>>> fixed, so I am wondering if something is wrong about HW_AUTO mode
>>> of CAM clock domain.
>>>
>> Now I recollect the issue and also track a patch in the internal pro=
duct
>> tree.
>> Same is attached and also in the end of the email.
>>
>> I am lopping Miguel who wrote the patch and Benoit who acked it.
>> This should sort out your issue as you have already verified it work=
s.
>
>
> Ooops, that remains me that I forgot to push it upstream:-(
>
> Since this is a bug fix, if this is too late for 3.3, we can try to p=
ush it
> during rc phases.
>
Cool. Thanks for picking it up

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
