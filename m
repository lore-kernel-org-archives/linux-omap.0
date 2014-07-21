From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap soc clean-up for v3.17 merge window
Date: Mon, 21 Jul 2014 10:51:57 -0700
Message-ID: <CAOesGMjpvJ5aYsw0ireWDEzYxKMQ3KOU6ofT9anc7dCZdC-3kQ@mail.gmail.com>
References: <20140721123000.GB18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:51152 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbaGURv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 13:51:58 -0400
Received: by mail-vc0-f169.google.com with SMTP id hu12so12935681vcb.14
        for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2014 10:51:57 -0700 (PDT)
In-Reply-To: <20140721123000.GB18374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Mon, Jul 21, 2014 at 5:30 AM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:
>
>   Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/soc-cleanup
>
> for you to fetch changes up to 3db53918e306d3960bf9e12eea8b2fd3f7d0fd62:
>
>   Merge tag 'for-v3.17/omap-clock-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.17/soc (2014-07-21 00:35:38 -0700)
>
> ----------------------------------------------------------------
>
> SoC specific omap clean-up for v3.17 merge window:
>
> - Changes to PRM and clock related code to help move
>   things to drivers
>
> - Removal of unused ctrl module defines that no longer
>   are needed with things moving to .dts files and
>   drivers
>

Merged, thanks.


-Olof
