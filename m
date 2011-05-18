From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Wed, 18 May 2011 13:48:51 -0500
Message-ID: <BANLkTikZaNpp-3TM732zXo2ASQR_Wq5yFA@mail.gmail.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com> <87fwocrmr9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34303 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933485Ab1ERSt1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 14:49:27 -0400
Received: by wyb40 with SMTP id 40so1627206wyb.7
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 11:49:11 -0700 (PDT)
In-Reply-To: <87fwocrmr9.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

On Wed, May 18, 2011 at 11:34, Kevin Hilman <khilman@ti.com> wrote:
> Basically, I'm in the process of a pretty major cleanup of the VC/VP =
and
> SR layers. =A0For example, in my pm-wip/voltdm_* branches, the debugf=
s
> interface to the voltage layer has been completely removed. =A0I'm al=
so
> thinking of removing the SR debugfs interface also, as I don't really
> think we need a userspace interface for this. =A0A board-level interf=
ace
> is probably enough (/me waits for flame from Nishanth :)
/me obliges with my 2cents ;) :

on board level interface - yes - we should have it.

on plugging out userspace:  This is too risky an approach - having a
mechanism to control SR from userspace is critical - yes folks can do
a regwrite over /dev/mem to plug it out, but with multiple SR classes,
it hardly ever going to be right. further, SR is a touchy beast to bad
clk and system configurations - if we view debugfs as what it was
meant to be: debug interface, SR deserves it. I agree that asking for
userspace to have a sysfs is not worth it if board level interface has
it. (and adding custom patches for every board developer out there...
well.. it is not really worth the pain).

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
