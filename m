From: iqbal shareef <iqbalshareef.list@gmail.com>
Subject: Re: Exclusive use of OMAP3 TI ISP Resizer
Date: Tue, 3 Feb 2009 21:00:51 +0530
Message-ID: <c6a924220902030730w6a08900ai8c4ef2d436d01ece@mail.gmail.com>
References: <c6a924220902030706t54cf015aq802d897c584e17dc@mail.gmail.com>
	 <A24693684029E5489D1D202277BE8944205B5FAC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:55515 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZBCPax (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 10:30:53 -0500
Received: by ewy14 with SMTP id 14so2496543ewy.13
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 07:30:51 -0800 (PST)
In-Reply-To: <A24693684029E5489D1D202277BE8944205B5FAC@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>, "Lakhani, Amish" <amish@ti.com>

To Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> wrote:
>> Hi
>>
>> Current TI ISP implementation doesn't allow exclusive use of Resizer,
>> I mean CCDC->Resizer.
>
> Yeah, we haven't added that functionality yet to the driver because we didn't have the need with our customers yet. But as more people like you are demanding this, then a solution for implementing it shall be discussed.
>

What kind of complexity/effort involved using just the resizer?

As my sensor gives YUV 4:2:2, I can directly feed this to the resizer
pipeline. To kick start could you please share a quick hack?  I can
then take it forward.

>>
>> Any specific reason why CCDC->Preview->Resizer path has been taken?
>> Please share the background of this decision.
>
> The reason on deciding about this ISP datapath is because we wanted to emphasize the use of the OMAP3 ISP, instead of the use of a sensor internal ISP.
>

I can see from your design that you have character device wrapper to
use Resizer, can we fit this hack with CCDC->Resizer logic? this is my
quick guess, correct If I am wrong.
>>
>> My sensor gives only YUV data, but the Preview pipeline is happy only
>> with RAW Bayer.
>> Is this a hardware limitation?
>
> Yeah, the ISP Preview module can only convert from 10-bit Bayer data to YCbCr 4:2:2 data (YUV).
>
