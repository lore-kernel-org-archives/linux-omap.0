From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Fri, 19 Mar 2010 17:53:44 +0200
Message-ID: <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
	 <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:39762 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab0CSPxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 11:53:46 -0400
Received: by bwz1 with SMTP id 1so158682bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 08:53:44 -0700 (PDT)
In-Reply-To: <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On Fri, Mar 19, 2010 at 1:51 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> I tried to rebase this patch on top of the latest head and the
> user-space client never gets notified of the MMUFAULT. After manually
> killing the process, the DSP is restarted correctly though.

Strike that. MMUFAULTS are not notified even before this patch... great.

-- 
Felipe Contreras
