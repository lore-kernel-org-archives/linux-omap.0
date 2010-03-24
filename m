From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Wed, 24 Mar 2010 23:14:15 +0200
Message-ID: <94a0d4531003241414y696aa379uc714c3fb7fc8c3eb@mail.gmail.com>
References: <Acq8TGBkJRXTEjd3QLyd0bJ27/2C7g==>
	 <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54936 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0CXVOU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 17:14:20 -0400
Received: by bwz1 with SMTP id 1so333411bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 14:14:19 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On Fri, Mar 5, 2010 at 12:12 PM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
> This patch implements a workqueue in charge of reseting
> DSP in case of fatal error.

I found another problem. It seems if after the mmu fault I close the
driver handle, and open it again on the same process, the driver
thinks the handle was never closed.

-- 
Felipe Contreras
