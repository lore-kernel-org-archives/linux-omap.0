From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Fri, 19 Mar 2010 18:18:30 +0200
Message-ID: <94a0d4531003190918v7e943d5ax16baf6945472530c@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
	 <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
	 <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41848 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0CSQSc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 12:18:32 -0400
Received: by bwz1 with SMTP id 1so181304bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 09:18:30 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On Fri, Mar 19, 2010 at 6:05 PM, Hebbar, Shivananda <x0hebbar@ti.com> wrote:
> Client app must register for MMUFault/DSPSysError events. Then only
> You will receive notifications.

It is registered, and it was receiving notifications on old versions
of the bridge... not any more.

-- 
Felipe Contreras
