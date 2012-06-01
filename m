From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv6 13/14] ARM: OMAP3: vc: auto_ret / auto_off support
Date: Fri, 1 Jun 2012 05:18:26 -0500
Message-ID: <CAOMWX4cJWjV+unHfJiDqeVSnAyN0gP+N0emG_iKPYsgwaGu7jQ@mail.gmail.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com> <1338472550-20743-14-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:36579 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932787Ab2FAKSu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 06:18:50 -0400
Received: by wgbed3 with SMTP id ed3so1478560wgb.8
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 03:18:48 -0700 (PDT)
In-Reply-To: <1338472550-20743-14-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, May 31, 2012 at 8:55 AM, Tero Kristo <t-kristo@ti.com> wrote:
>
> + =A0 =A0 =A0 case PWRDM_POWER_RET:
Apologies on hijacking this thread, but I do think we need to revisit
this series after rebase
on top of Jean's series - it otherwise results a mess of different
sets of macros.

IMHO though, it might be a good time to discuss if we would like to
switch from macros to
enums to become as much as possible type safe in usage - it is just
too easy for later
developers who will maintain this code from mistakenly using wrong
macros at the wrong
place and causing others to spend weeks debugging?

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
