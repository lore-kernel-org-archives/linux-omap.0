From: Suresh Rajashekara <suresh@mistralsolutions.com>
Subject: Re: unknown partition table
Date: Mon, 16 Jun 2008 10:56:59 -0700
Message-ID: <4856A96B.7040807@mistralsolutions.com>
References: <a1d91fa0806161043w108cfe67o51ebc0ec45cb8fe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:47554 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYFPR5B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2008 13:57:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3732029rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 10:57:01 -0700 (PDT)
In-Reply-To: <a1d91fa0806161043w108cfe67o51ebc0ec45cb8fe7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-newbie@vger.kernel.org

mohammed shareef wrote:

> sda: Write Protect is off
> sda: assuming drive cache: write through
>  sda:<7>usb-storage: queuecommand called
>  unknown partition table
> sd 0:0:0:0: Attached scsi removable disk sda

Try formatting once. Use fdisk (on Linux) to format it and make partitions.

Regards,
Suresh
