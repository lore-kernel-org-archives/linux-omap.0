From: Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 13:07:14 +0000
Message-ID: <201111221307.14942.arnd.bergmann@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<1321926047-14211-6-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321926047-14211-6-git-send-email-mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 22 November 2011, Mike Turquette wrote:
> Introduces kobject support for the common struct clk, exports per-clk
> data via read-only callbacks and models the clk tree topology in sysfs.
> 
> Also adds support for generating the clk tree in clk_init and migrating
> nodes when input sources are switches in clk_set_parent.
> 
> Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/clk/Kconfig     |   10 +++
>  drivers/clk/Makefile    |    1 +
>  drivers/clk/clk-sysfs.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk.c       |    5 +-
>  include/linux/clk.h     |   36 ++++++++-
>  5 files changed, 248 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/clk/clk-sysfs.c

Since this introduces a new top-level hierarchy in sysfs, it certainly needs
to be reviewed by Greg K-H (on Cc now). Also, you have to add a proper
documentation for every new node and attribute in Documentation/ABI along
with the code.

> +static struct kobject *clk_kobj;
> +LIST_HEAD(kobj_list);

The list head should be static.

	Arnd
