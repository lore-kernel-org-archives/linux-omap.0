From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: regression: crash from 'ls /sys/modules/wl1251_spi/notes'
Date: Sat, 02 Jan 2010 10:34:22 -0600
Message-ID: <1262450062.2741.4.camel@mulgrave.site>
References: <87k4w4wux9.fsf@purkki.valot.fi>
	 <1262188157.2749.21.camel@mulgrave.site>
	 <2375c9f90912311908r667966e1m919430c40cd9c571@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <2375c9f90912311908r667966e1m919430c40cd9c571@mail.gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, Helge Deller <deller@gmx.de>, rusty@rustcorp.com.au, akpm@linux-foundation.org, roland@redhat.com, dave@hiauly1.hia.nrc.ca, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-01-01 at 11:08 +0800, Am=C3=A9rico Wang wrote:
> This patch looks fine for me, except that I don't think it's necessar=
y
> to introduce an inline function for that...

Actually, I really think we do.  The whole reason we got into this mess
in the first place is that it wasn't obvious from the code that if we
altered the loadability of sections, there were a ton of dependent
places we also had to update.  Putting all that knowledge into a single
inline makes the same mistake impossible to make because there's now
only one place to go to adjust the loadability of sections, and it
automatically takes care of all the dependencies.

> Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks,

James


--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
