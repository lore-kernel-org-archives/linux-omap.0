From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] dspbridge: reorganize initialization and probe
Date: Wed, 9 Jun 2010 10:25:17 +0300
Message-ID: <AANLkTil4gAHQcEdAedxamD9mi5d-0CxGLqP_8h9vY77j@mail.gmail.com>
References: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34317 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0FIHZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 03:25:19 -0400
Received: by bwz11 with SMTP id 11so1442838bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Jun 2010 00:25:18 -0700 (PDT)
In-Reply-To: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>

On Wed, Jun 9, 2010 at 3:48 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Split the functions to have cleaner error handling paths, this
> will aslo cover a case where bridge initialization has failed but
> device entry is still available which leads to unknown behavior.

Great, I was wondering why this was not the case.

Now that you are on this, do you know if there's something missing in
order to automatically load the module when somebody tries to open
/dev/DspBridge?

-- 
Felipe Contreras
