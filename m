From: "Turquette, Mike" <mturquette-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 2/6] Documentation: common clk API
Date: Thu, 5 Jan 2012 12:04:44 -0800
Message-ID: <CAJOA=zMEPW1vX_+KVexoLh0r4kO+vZ4zJQhsgDxwuu_7edFTgg@mail.gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
	<1323834838-2206-3-git-send-email-mturquette@linaro.org>
	<20120105143105.GA2865@matterhorn1>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20120105143105.GA2865@matterhorn1>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-l0cyMroinI0@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 5, 2012 at 6:31 AM, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wr=
ote:
> Tiny, tiny typo...
>
> On 11 Dec 13, Mike Turquette wrote:
>
>> +clk_set_rate deserves a special mention because it is more complex than
>> +the other operations. =A0There are three key concepts to the common
>> +clk_set_rate implementation:
>> +
>> +1) recursively traversing up the clk tree and changing clk rates, one
>> +parent at a time, if each clk allows it
>> +2) failing to change rate if the clk is enabled and must only change
>> +rates while disabled
>> +3) using clk rate change notifiers to allow devices to handle dynamic
>> +rate changes for clks which do support changing rates while enabled
>> +
>> +For the simple, non-recursive case the call graph looks like:
>> +
>> +clk_set_rate(clk, rate);
>> + =A0 =A0 __clk_set_rate(clk, rate);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk->round_rate(clk, rate *parent_rate);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0^^^^^^^^
>
> need a comma here? The next sentence kept me busy for 5 mins.

Thanks, will fix in next submission (along with general rework of
messy documentation).

Mike

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk->set_rate(clk, rate);
>> +
>> +You might be wondering what that third paramater in .round_rate is. =A0=
If
>> +a clk supports the CLK_PARENT_SET_RATE flag then that enables it's
>> +hardware-specific .round_rate function to provide a new rate that the
>> +parent should transition to. =A0For example, imagine a rate-adjustable =
clk
>> +A that is the parent of clk B, which has a fixed divider of 2.
