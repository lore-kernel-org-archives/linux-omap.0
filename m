From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] staging: tidspbridge: fix incorrect free to drv_datap
Date: Tue, 31 Jan 2012 12:19:00 -0600
Message-ID: <CAB-zwWg9iudV7o5opYHOMHo8HN9EGB+n0f=mAHQCNWZovHrdvQ@mail.gmail.com>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
	<1327972818-30993-3-git-send-email-omar.ramirez@ti.com>
	<20120131082136.GC3294@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39025 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752325Ab2AaSTM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 13:19:12 -0500
Received: by mail-ww0-f43.google.com with SMTP id dr13so446605wgb.0
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 10:19:01 -0800 (PST)
In-Reply-To: <20120131082136.GC3294@mwanda>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Tue, Jan 31, 2012 at 2:21 AM, Dan Carpenter <dan.carpenter@oracle.co=
m> wrote:
> On Mon, Jan 30, 2012 at 07:20:18PM -0600, Omar Ramirez Luna wrote:
>> This structure is still used after it has been freed, since it
>> is being allocated in probe, calls to free it have been moved to
>> module's remove routine.
>>
>> This should fix the follwoing messages when attempting to remove the
>> module:
>> =A0drv_get_first_dev_extension: Failed to retrieve the object handle
>> =A0drv_get_first_dev_extension: Failed to retrieve the object handle
>> =A0drv_destroy: Failed to store DRV object
>> =A0mgr_destroy: Failed to store MGR object
>>
>
> So this is only triggered when you do an rmmod to remove the module?

Yes.

> Probably that's not stable material.

The critical issue is that for a small window the freed memory can be
filled with something else and the driver still might dereference that
memory which no longer belongs to it, thus causing a crash.

But I guess that falls into "this can be a problem", it is ok if it is
being left out of stable.

Thanks,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
