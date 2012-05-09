From: Enrico <ebutera@users.berlios.de>
Subject: Re: [GIT PULL] omap fixes for v3.4-rc6
Date: Wed, 9 May 2012 10:32:02 +0200
Message-ID: <CA+2YH7v54P7hSvPo=6eiNKQNgyxfBhpBxOLQZcfd4Zt_CzPrFQ@mail.gmail.com>
References: <20120507223632.GP5088@atomide.com>
	<CAOesGMjHEy0Rz+ow7J3BuUtt3h3SjU+6gG=PPGTu3tMNZXy6nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60914 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab2EIIcE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 04:32:04 -0400
Received: by vbbff1 with SMTP id ff1so15957vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 01:32:03 -0700 (PDT)
In-Reply-To: <CAOesGMjHEy0Rz+ow7J3BuUtt3h3SjU+6gG=PPGTu3tMNZXy6nQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

On Wed, May 9, 2012 at 8:48 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Mon, May 7, 2012 at 3:36 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
>> The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa653=
9a6a98a:
> [..]
>> Enrico Butera (1):
>> =A0 =A0 =A0ARM: OMAP: igep0020: fix smsc911x dummy regulator id
>
> Hmm. Picking 40 without any kind of comment in the code isn't doing
> any favors for future readers. Seems like 1 would be free on this
> board, from the rest of the board file to judge (one other
> reg-fixed-regulator platform device)?
>
> Please either comment why you picked 40 (i.e. it's a random number),
> or change it to something a little less random like 1. :)

Yes i verified that 1 is free, i will send an updated patch.

Enrico
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
