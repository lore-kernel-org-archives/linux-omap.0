From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] OMAP clock: implement clock rate/parent change notifiers
Date: Sun, 14 Aug 2011 10:39:56 +0300
Message-ID: <CAMP44s0qzSoDJbvzVOHNDbROPPWQH328LYKXSoLav+49vv-z_g@mail.gmail.com>
References: <20090325160759.31866.49722.stgit@localhost.localdomain>
	<87tz5hwks8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35216 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1HNHj6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Aug 2011 03:39:58 -0400
Received: by bke11 with SMTP id 11so2430838bke.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Aug 2011 00:39:57 -0700 (PDT)
In-Reply-To: <87tz5hwks8.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

Hi,

On Wed, Mar 25, 2009 at 7:54 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>> This series allows core code and driver code to register for
>> notification when a clock's rate or parent changes. =C2=A0This is cu=
rrently
>> used by driver code that must be notified whenever power management
>> code (e.g., CPUFreq) causes system rate changes that affect the driv=
er's
>> clock.
>
> I will be re-basing the PM branch onto today's linux-omap HEAD which
> is v2.6.29 based. =C2=A0As I do this, I'll be dropping all the previo=
us
> notifier patches and replacing them with this series.

What happened to this series? I don't see it anywhere.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
