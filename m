From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 12:19:51 -0700
Message-ID: <CACxGe6vK-vHvSbd9N2k3FZY4gGVS_DETx0BbfPgNghTkOncjpg@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<1321926047-14211-6-git-send-email-mturquette@linaro.org>
	<CACxGe6sOd6MiyYaok6BsihJtp-NNsm3WQf+aUPGMRFRpSLw2mQ@mail.gmail.com>
	<CAPtuhTheG-mvoGMaB2y9BSKF-abm2yigoN-SXaeCb+P5R6t_Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAPtuhTheG-mvoGMaB2y9BSKF-abm2yigoN-SXaeCb+P5R6t_Dg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 11:01 AM, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wr=
ote:
> On Tue, Nov 22, 2011 at 8:37 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>=
 wrote:
>>
>> On Nov 21, 2011 6:43 PM, "Mike Turquette" <mturquette-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>> Introduces kobject support for the common struct clk, exports per-clk
>>> data via read-only callbacks and models the clk tree topology in sysfs.
>>>
>>> Also adds support for generating the clk tree in clk_init and migrating
>>> nodes when input sources are switches in clk_set_parent.
>>
>> I'm not convinced this is a good idea. What is the use case for exporting
>> the clock tree? If it is debug, then I suggest using debugfs to avoid abi
>> issues.
>
> Each clk exports clk_rate, clk_flags, clk_enable_count &
> clk_prepare_count as Read-Only. =A0I think this is very reasonable to
> have in sysfs, which maps the topology of the system with key details.
>
> Others have requested to have knobs made available for actually
> performing clk_enable/clk_disable and even clk_set_rate from
> userspace. =A0I hate this idea and won't implement it. =A0I encourage
> anyone that needs this to do it in debugfs.
>
> Does that work-split make sense to you, or do you still not like the
> idea of having topology and read-only info in sysfs?

Unless there is a solid real-world use case for exporting this data to
userspace, I do not think sysfs is a good idea.  As long as the usage
(beyond debug) is theoretical I think the whole thing should be in
debugfs.  It can always be moved at a later date If a real use case
does become important.

g.
