From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: HELP:dspbridge:how to configure GPT timer
Date: Mon, 11 Apr 2011 10:07:06 -0500
Message-ID: <BANLkTikzsrbi8EytVzm9ZA2djtrjnAAcmQ@mail.gmail.com>
References: <BANLkTin49cr76MXFUv6CZSs_-4v6=wL0Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52705 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754173Ab1DKPHI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 11:07:08 -0400
Received: by mail-wy0-f172.google.com with SMTP id 29so7551644wyb.17
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 08:07:06 -0700 (PDT)
In-Reply-To: <BANLkTin49cr76MXFUv6CZSs_-4v6=wL0Uw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: onlyfever <onlyfever@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Sat, Apr 9, 2011 at 7:38 AM, onlyfever <onlyfever@gmail.com> wrote:
> Hi all!
> currently dsp make use of gpt 5, 6, 7 or 8.
> I'm using gpt 8 for something else.
> Is it possible to configure dsp-bridge to use other gpt timer?
> I want to change gpt 8 to gpt 9,or gpt 7.
> Please give me some advice.

GPT8 is used for avsync on the dsp side, unfortunately there is no way
to change this without dsp sources and the latter are not publicly
available :/

Regards,

Omar
