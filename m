Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B03F4831;
	Sat, 12 Sep 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231625; cv=none; b=QN39WsiCTsLziOzmBKWYyv30E9CT2GLR2FDM5p2rNBqgue+EVIJz9B6AAsTwHIBL0JkqcLEfxwIeJkxL5JO+VwX+5x6Q3DcQak5ExOy4xe6idtPJuckD9HhPNsACnY10kB6Z/OmxuhjJO9Yr64CgVHx0FlG7+8I1dnMCLdEVy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231625; c=relaxed/simple;
	bh=FJU8q53J2SJ+iuX4vWB2+PesDyEK1S5ACfblKzZIXjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDAiaQPjXdpGUeW4G99Wu8mzqghCI3u9tapiKUzxXu9bFwgL5hTn9AXwrhyvTR8AWeFJa/HLXHZfoCQyBN0AF/xg4wvMTQmoIuynUCBLNldp59VON/IodRmxslwoZ9Rf5KiCIAKfX7rOD/WIl8EMHju7qU6xwGCXCslZsj2+lWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SIkBq/Dj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SIkBq/Dj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789231608; x=1789836408; i=deller@gmx.de;
	bh=7G0xZl5kIWgmTqXxm4xs2xlGIMXSqPhJhlV0xmiCK88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SIkBq/DjLT4ubzG+Qvox5Z98rEcg/QKcpzOx8bpe8kH07xNzsObiZwBtZp4JSnKs
	 mxngkhTqQG1VoMY925MuV2dX0muoJERLkda1CtQnFfOzS7wTSfSCIwWZ5IcTRAgUe
	 gdgVY3gK/ilGqI+iX+gai4/HaJDpItaChspsWLKgxlLRGpfpHwZs2txiYNRq8VwCc
	 ICJHOoNzZjKag6YDNPpijSljC1TqMryMSATfYURVPjvH2KC9XMh7EOiQvF4zDyw7j
	 kMk4YBol/0Tnl7kkVdVV+4MX3AyAYtMKxLv2xjbL6aOkRACg1TUhYILsCsNGYYlrl
	 dlPzofM/rziNy5WNqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1wjy4A32GY-016wol; Sat, 12
 Sep 2026 18:46:48 +0200
Message-ID: <973b9e09-1fef-492b-9510-bb25d158b2d9@gmx.de>
Date: Sat, 12 Sep 2026 18:46:43 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Jones <pjones@redhat.com>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
References: <20260904111355.25780-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260904111355.25780-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nPMsOSMslWcB5R91yz5E2CXbItIKdjsUnMMqD6XE3Il01mnKzre
 CKacC6E140BTLuXp50LOr3FBBIlTXwPp7Zv2WCKOLuKQFH28W5Gr/dWUq+5qiZrFtxkxA/g
 M2Hzs2YWYn5TDZRF7tmOA5jzzSjZa/bAM3HiBp3pUda3+OqELQq71QMyAQN7VKB1sVHW4qb
 ihHc9fzUtn+k5Hqj5u7yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8Ilvf7v7O3c=;SfaHV0dtjDCw/YJY4iodEf7Ynlf
 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
 5+9OC5bC1F8GCIpmi+H4KPWiz2AHjGJ

On 9/4/26 13:13, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no cod=
e
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>   drivers/video/fbdev/aty/aty128fb.c              | 2 +-
>   drivers/video/fbdev/aty/atyfb_base.c            | 4 ++--
>   drivers/video/fbdev/aty/mach64_cursor.c         | 2 +-
>   drivers/video/fbdev/aty/radeon_base.c           | 4 ++--
>   drivers/video/fbdev/aty/radeon_monitor.c        | 4 ++--
>   drivers/video/fbdev/aty/radeonfb.h              | 2 +-
>   drivers/video/fbdev/au1100fb.c                  | 2 +-
>   drivers/video/fbdev/efifb.c                     | 4 ++--
>   drivers/video/fbdev/grvga.c                     | 2 +-
>   drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 2 +-
>   drivers/video/fbdev/maxinefb.c                  | 2 +-
>   drivers/video/fbdev/mmp/core.c                  | 2 +-
>   drivers/video/fbdev/mmp/hw/mmp_ctrl.c           | 4 ++--
>   drivers/video/fbdev/mmp/hw/mmp_ctrl.h           | 4 ++--
>   drivers/video/fbdev/mmp/hw/mmp_spi.c            | 2 +-
>   drivers/video/fbdev/ocfb.c                      | 2 +-
>   drivers/video/fbdev/omap2/omapfb/dss/dispc.c    | 4 ++--
>   drivers/video/fbdev/pm2fb.c                     | 2 +-
>   drivers/video/fbdev/skeletonfb.c                | 6 +++---
>   drivers/video/fbdev/sstfb.c                     | 2 +-
>   drivers/video/fbdev/tgafb.c                     | 6 +++---
>   drivers/video/fbdev/tridentfb.c                 | 2 +-
>   drivers/video/fbdev/via/dvi.c                   | 6 +++---
>   drivers/video/fbdev/via/hw.c                    | 2 +-
>   drivers/video/fbdev/via/viafbdev.c              | 4 ++--
>   drivers/video/sticore.c                         | 2 +-
>   include/video/mmp_disp.h                        | 6 +++---
>   27 files changed, 43 insertions(+), 43 deletions(-)
I've splitted it up in smaller patches per driver and applied them.

Thanks!
Helge
