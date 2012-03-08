From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 10/13] gpio/omap: fix missing dataout context save in _set_gpio_dataout_reg
Date: Thu, 8 Mar 2012 09:04:27 +0530
Message-ID: <CAC83ZvKuOfd3kxJSdsU2W_si92zzAOn+gpvLAcVOfPdsEH8+gA@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-11-git-send-email-tarun.kanti@ti.com>
	<4F574EA6.4000807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50365 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302Ab2CHDe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 22:34:28 -0500
Received: by mail-qy0-f173.google.com with SMTP id c20so46126qcs.32
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 19:34:27 -0800 (PST)
In-Reply-To: <4F574EA6.4000807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, Mar 7, 2012 at 5:33 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
>> There are two functions, _set_gpio_dataout_reg() and _set_gpio_dataout_mask()
>> which writes to dataout register and the dataout context must be saved.
>> It is missing in the first function, _set_gpio_dataout_reg(). Fix this.
>>
>> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
> Good catch. Is the suspend/resume caught this issue?
That's right.
--
Tarun
>
> This can go as a fix as well.
>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Regards
> Santosh
