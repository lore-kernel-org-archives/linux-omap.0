From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 6/8] OMAP2+: cpufreq: fix freq_table leak
Date: Thu, 26 May 2011 11:34:15 -0700
Message-ID: <BANLkTikjN4apwFS9NWwKmA+5peSh4Aztmg@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-7-git-send-email-nm@ti.com>
 <877h9ejoy1.fsf@ti.com> <BANLkTimp35KXz6WFbMWgAMdy=szYYES4mg@mail.gmail.com> <87fwo1gzdw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40365 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757637Ab1EZSeh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 14:34:37 -0400
Received: by mail-ww0-f42.google.com with SMTP id 4so4737750wwk.1
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 11:34:35 -0700 (PDT)
In-Reply-To: <87fwo1gzdw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, May 26, 2011 at 10:11, Kevin Hilman <khilman@ti.com> wrote:
>
> When you're talking about potentially concurrent modification of data=
,
> that make sense. =A0Here you're implementing a plugin for an existing
> framework, and you can (and have to) make assumptions about when the
> callbacks are used.
ok, that is the one i was looking for. thanks. will use atomic ops and
drop the mutex.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
