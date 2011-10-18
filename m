From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Add conditional compilation for board
 specific init functions
Date: Tue, 18 Oct 2011 22:01:41 +0200
Message-ID: <CAAwP0s3UOr9kaEmE-kVx8qExGexHkSkN=eNa1RB8veQ9wBBkug@mail.gmail.com>
References: <1318629618-5313-1-git-send-email-martinez.javier@gmail.com> <CAM9fjH6TZnAWAPvp8Uvr4hHpf77CeRz3k=hv6FGN73X1aXTXQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58454 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab1JRUCB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Oct 2011 16:02:01 -0400
Received: by gyb13 with SMTP id 13so947061gyb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Oct 2011 13:02:01 -0700 (PDT)
In-Reply-To: <CAM9fjH6TZnAWAPvp8Uvr4hHpf77CeRz3k=hv6FGN73X1aXTXQQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyle Manna <kyle.manna@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, Oct 18, 2011 at 8:36 PM, Kyle Manna <kyle.manna@gmail.com> wrot=
e:
> Looks like you're missing one more section for OMAP3. Will reply with
> a complete patch I was about to submit.
>

Yes, I added all the ones I need to compile my board correctly, but I
could have missed one of them.

Perfect, feel free to add this fix on your patch.

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
