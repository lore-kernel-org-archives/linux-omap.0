From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH] usb: musb: fix pm_runtime calls while atomic
Date: Fri, 12 Aug 2011 09:49:46 -0700
Message-ID: <CAFm5wm1W03BbjNV4uZLGNjFZLKvfiLLQyP3M01r83EQ47724wQ@mail.gmail.com>
References: <1313159931-22121-1-git-send-email-vikram.pandita@ti.com> <Pine.LNX.4.44L0.1108121149160.11936-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40222 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682Ab1HLQuz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 12:50:55 -0400
In-Reply-To: <Pine.LNX.4.44L0.1108121149160.11936-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, axelhaslam@ti.com, ccross@google.com, Moiz Sonasath <m-sonasath@ti.com>

On Fri, Aug 12, 2011 at 8:50 AM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Fri, 12 Aug 2011, Vikram Pandita wrote:
>
>> From: Vikram Pandita <vikram.pandita@ti.com>
>>
>> musb pm_runtime_get_sync call happens in intrrupt context on cable a=
ttach case
>> That can result in re-enabling the interrupts and cause side affects=
=2E
>>
>> So move the code to a work queue.
>
> Instead of creating your own, new work queue, just use the pre-existi=
ng
> PM work queue. =A0In other words, replace pm_runtime_get_sync() with
> pm_runtime_get().

In this case it may not work, because immediately after a
pm_runtime_get_sync(),
we are going to access MUSB registers and xxx_sync()  call ensures we
will not abort.


>
> Alan Stern
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
