From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: expand the description of the
 debug facility
Date: Wed, 7 Oct 2015 14:07:45 +0300
Message-ID: <5614FD01.6090009@ti.com>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com> <20151007075338.GH3982@pengutronix.de>
 <20151007102822.GT23801@atomide.com> <20151007110231.GL3982@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151007110231.GL3982@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On 07/10/15 14:02, Uwe Kleine-K=F6nig wrote:
> Hello Tony,
> =

> On Wed, Oct 07, 2015 at 03:41:19AM -0700, Tony Lindgren wrote:
>> * Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [151007 00:57]:
>>> On Wed, Oct 07, 2015 at 10:45:50AM +0300, Roger Quadros wrote:
>>>>
>>>> How about this instead?
>>>>
>>>> NOTE: Apart from matching the register setup with the bootloader you a=
lso need to
>>>> match the GPMC FCLK frequency used by the bootloader else the GPMC tim=
ings
>>>> won't be identical with the bootloader timings.
>>> Yeah, sounds better, thanks.
>>>
>>>> Also you might need to build this patch on top of
>>>> http://article.gmane.org/gmane.linux.kernel/2054796
>>> I talked to Tony about this patch yesterday on irc, but I didn't find it
>>> in the archives yet when I sent my mail.
>>
>> Yes sorry here's a repost with your and Roger's changes folded in and
>> edited a bit. Probably best to keep them together with this patch.
>>
>> Does the following look OK to you guys?
> Yes,
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Looks good to me too.

cheers,
-roger
