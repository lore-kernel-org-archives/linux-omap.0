From: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Subject: Re: [PATCH] omapfb: setting GOLCD bit for shadow registers to make
     effect
Date: Tue, 9 Sep 2008 13:45:49 +0100 (BST)
Message-ID: <55149.194.202.59.151.1220964349.squirrel@mail.mansr.com>
References: <c656a4d20809080219q545ccff3v13221d2287f6de30@mail.gmail.com>
    <yw1xtzcq76dr.fsf@thrashbarg.mansr.com>
    <20080909123549.GL31563@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:44588 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbYIIMpv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Sep 2008 08:45:51 -0400
In-Reply-To: <20080909123549.GL31563@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel.stone@nokia.com>
Cc: linux-omap@vger.kernel.org


Daniel Stone wrote:
> On Mon, Sep 08, 2008 at 09:02:56PM +0100, ext M=C3=A5ns Rullg=C3=A5rd=
 wrote:
>> "arun c" <arunedarath@mistralsolutions.com> writes:
>> > +	while (dispc_read_reg(DISPC_CONTROL) & (1 << 5))
>> > +		continue;
>> > +	MOD_REG_FLD(DISPC_CONTROL, 1 << 5, 1 << 5);
>> > +
>> >  	return height * screen_width * bpp / 8;
>> >  }
>>
>> This looks good.  However, the same thing is needed in
>> omap_dispc_enable_plane() as well.  Placing the loop+set in a functi=
on
>> (go_lcd()?) would make sense.
>
> Preferably something with a slightly more generic name, so it could
> also fire GODIGITAL for digital out, when support for that exists.

I agree; didn't think of that at first.

--=20
M=C3=A5ns Rullg=C3=A5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
