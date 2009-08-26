From: Frederik Kriewitz <frederik@kriewitz.eu>
Subject: Re: LCD blanking?
Date: Wed, 26 Aug 2009 02:36:45 +0200
Message-ID: <f67028d40908251736i1fb8037dy5aa41dad2d6621ca@mail.gmail.com>
References: <4A93ED3E.4030505@mlbassoc.com>
Reply-To: frederik@kriewitz.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:38016 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745AbZHZAhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 20:37:04 -0400
Received: by bwz19 with SMTP id 19so2248516bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 25 Aug 2009 17:37:05 -0700 (PDT)
In-Reply-To: <4A93ED3E.4030505@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 25, 2009 at 3:55 PM, Gary Thomas<gary@mlbassoc.com> wrote:
> I have a system with an LCD, running Tomi's DSS2 support.
> One problem I'm having is that after a while, the LCD blanks
> out (I do have fbcon support enabled so I can use it as a
> glass TTY - no keyboard)
>
> How can I keep this from happening?
> Once it does, is there any way to get it back on (remember,
> no keyboard)?

check man console_codes
