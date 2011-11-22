From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 09:42:58 -0800
Message-ID: <CAPtuhTiVR6NQfgH6-JGd6EC68bdOb6JwDKqaiswS8YR3sNt-Vg@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org> <201111221307.14942.arnd.bergmann@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201111221307.14942.arnd.bergmann@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Mike Turquette <mturquette@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, aul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, eric.miao@linaro.org, richard.zhao@linaro.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 5:07 AM, Arnd Bergmann <arnd.bergmann@linaro.or=
g> wrote:
> On Tuesday 22 November 2011, Mike Turquette wrote:
>> Introduces kobject support for the common struct clk, exports per-cl=
k
>> data via read-only callbacks and models the clk tree topology in sys=
fs.
>>
>> Also adds support for generating the clk tree in clk_init and migrat=
ing
>> nodes when input sources are switches in clk_set_parent.
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> ---
>> =A0drivers/clk/Kconfig =A0 =A0 | =A0 10 +++
>> =A0drivers/clk/Makefile =A0 =A0| =A0 =A01 +
>> =A0drivers/clk/clk-sysfs.c | =A0199 ++++++++++++++++++++++++++++++++=
+++++++++++++++
>> =A0drivers/clk/clk.c =A0 =A0 =A0 | =A0 =A05 +-
>> =A0include/linux/clk.h =A0 =A0 | =A0 36 ++++++++-
>> =A05 files changed, 248 insertions(+), 3 deletions(-)
>> =A0create mode 100644 drivers/clk/clk-sysfs.c
>
> Since this introduces a new top-level hierarchy in sysfs, it certainl=
y needs
> to be reviewed by Greg K-H (on Cc now). Also, you have to add a prope=
r
> documentation for every new node and attribute in Documentation/ABI a=
long
> with the code.

I don't intend to keep it in the top-level /sys/ directory.  I
mentioned that in the coverletter, but not here.  I wasn't sure where
to put it, and I knew reviewers would be happy to point the right
place out to me.

>> +static struct kobject *clk_kobj;
>> +LIST_HEAD(kobj_list);
>
> The list head should be static.

Will put into V4.

Thanks,
Mike

>
> =A0 =A0 =A0 =A0Arnd
>
