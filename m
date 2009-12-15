From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/17] DSPBRIDGE: Implemented Trampoline support for
	dynamic loader
Date: Tue, 15 Dec 2009 20:24:32 +0200
Message-ID: <94a0d4530912151024v43b5941apdc3afeb00e18145c@mail.gmail.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
	 <1260857998-19349-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:52778 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760833AbZLOSYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 13:24:32 -0500
Received: by iwn1 with SMTP id 1so104351iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 10:24:32 -0800 (PST)
In-Reply-To: <1260857998-19349-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

On Tue, Dec 15, 2009 at 8:19 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> From: Fernando Guzman Lugo <x0095840@ti.com>
>
> Implemented on dynamic loader automatic generation of
> trampolines when near calls are made to outside of signed
> 21-bit offset available in the C64X+ DSP.

The commit message is not clear: Why do we want this? What problem is
fixed? Is old behavior changed, or is it an independent feature?

-- 
Felipe Contreras
