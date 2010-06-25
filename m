From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 14:13:15 -0600
Message-ID: <AANLkTikYE6Kg8C_ZClx9aKLvOa9CQRUT587hQnB91sua@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<20100625200659.GB22090@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46849 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0FYUNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 16:13:35 -0400
Received: by iwn41 with SMTP id 41so2343228iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 13:13:35 -0700 (PDT)
In-Reply-To: <20100625200659.GB22090@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Fri, Jun 25, 2010 at 2:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jun 25, 2010 at 09:26:43AM -0600, Grant Likely wrote:
>> This approach is also not multiplatform friendly (cc'ing Eric and
>> Nicolas who are working on ARM multiplatform). =A0It won't work for
>> building a kernel that supports, say, both versatile and OMAP.
>
> And I should also point out that multiplatform is not the answer to
> Linus' concerns. =A0There's no way such work is going to be anywhere
> near complete come the next merge window.

Yes, but solving the defconfig problem isn't the reason for multiplatfo=
rm.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
