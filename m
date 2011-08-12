From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH] usb: musb: use put_sync_suspend instead of put_sync
Date: Fri, 12 Aug 2011 07:40:09 -0700
Message-ID: <CAFm5wm2x_kpsgMJSo8J+Q0=CvfdpPvxzfdOPjbFzZ6AQq0QpZg@mail.gmail.com>
References: <1312494011-18745-1-git-send-email-m-sonasath@ti.com>
 <87fwlgww0y.fsf@ti.com> <20110812090106.GH19467@legolas.emea.dhcp.ti.com> <CAFm5wm3vsOye4uMA3f5f6u5emGb2fk4n3Yc+aRUGHJM8PJ+DnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38725 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752702Ab1HLOko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 10:40:44 -0400
In-Reply-To: <CAFm5wm3vsOye4uMA3f5f6u5emGb2fk4n3Yc+aRUGHJM8PJ+DnA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Moiz Sonasath <m-sonasath@ti.com>, linux-usb@vger.kernel.org, ccross@google.com, linux-omap@vger.kernel.org, gregkh@suse.de, Axel Haslam <axelhaslam@ti.com>

On Fri, Aug 12, 2011 at 6:55 AM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
> On Fri, Aug 12, 2011 at 2:01 AM, Felipe Balbi <balbi@ti.com> wrote:
>> Hi,
>>
>> (sorry for top-posting)
>>
>> Moiz, are we going to have another set of this ?
>
> The problem was with pm_runtime() functions getting called from atomic
> context and we did a work around by calling the runtime functions from
> a work queue.
> That seems to fix the issue. We will post that out as an alternative
> to marking the irq_safe and thus causing the parent to never idle.
>

Here is the new post:
https://patchwork.kernel.org/patch/1061282/

[.....]
