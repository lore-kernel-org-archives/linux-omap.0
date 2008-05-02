From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: OMAP SDL
Date: Sat, 3 May 2008 01:02:50 +0200
Message-ID: <fb249edb0805021602r3a5de297i882ee565fad67c11@mail.gmail.com>
References: <DF2E621E2E4C14428B271D6363D915C801131DB7@dnce03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:54769 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180AbYEBXCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 19:02:54 -0400
Received: by ug-out-1314.google.com with SMTP id h3so165895ugf.16
        for <linux-omap@vger.kernel.org>; Fri, 02 May 2008 16:02:52 -0700 (PDT)
In-Reply-To: <DF2E621E2E4C14428B271D6363D915C801131DB7@dnce03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Royer, Fabien" <f-royer@ti.com>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org

On 02/05/2008, Royer, Fabien <f-royer@ti.com> wrote:
>  First, I try a program which print a helloWorld on the Screen. But the
>  probleme is that the Fonction SDL_Init doesn't work properly for
>  SDL_INIT_VIDEO.
>
>
>
>  I get the message with SDL_GetError() , error=enable to open mouse.

Are you running this in X? If not, you may have set SDL_MOUSEDRV and
SDL_MOUSEDEV manually (e.g. to some /dev/input/eventN node).  I don't
know if there's a "dummy" mouse drv in sdl.

HTH
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
