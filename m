From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for v3.4-rc6
Date: Tue, 8 May 2012 23:48:06 -0700
Message-ID: <CAOesGMjHEy0Rz+ow7J3BuUtt3h3SjU+6gG=PPGTu3tMNZXy6nQ@mail.gmail.com>
References: <20120507223632.GP5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:62205 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab2EIGsG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 02:48:06 -0400
Received: by gglu4 with SMTP id u4so1357453ggl.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 23:48:06 -0700 (PDT)
In-Reply-To: <20120507223632.GP5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ebutera@users.berlios.de, laurent.pinchart@ideasonboard.com

Hi,

On Mon, May 7, 2012 at 3:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539=
a6a98a:
[..]
> Enrico Butera (1):
> =A0 =A0 =A0ARM: OMAP: igep0020: fix smsc911x dummy regulator id

Hmm. Picking 40 without any kind of comment in the code isn't doing
any favors for future readers. Seems like 1 would be free on this
board, from the rest of the board file to judge (one other
reg-fixed-regulator platform device)?

Please either comment why you picked 40 (i.e. it's a random number),
or change it to something a little less random like 1. :)

> Laurent Pinchart (1):
> =A0 =A0 =A0ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditi=
onally

Is this a regression? I don't see any recent changes regarding this,
so it's hard to tell. If not then I'd rather hold off for the merge
window given that we're at -rc6.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
