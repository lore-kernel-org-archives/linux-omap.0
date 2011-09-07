From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
Date: Wed, 7 Sep 2011 10:54:11 +0530
Message-ID: <CAC83ZvKoSsGNMDoHNeCOZXk9mOZxcKjT_vMjnXGQn6F52YNDKg@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<87ty8pz384.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87ty8pz384.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 7, 2011 at 4:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Tarun,
>
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>> The cleanup include getting rid of cpu_is_* checks wherever possible,
>> use of gpio_bank list instead of static array, use of unique platform
>> specific value associated data member to OMAP platforms to avoid
>> cpu_is_* checks. The series also include PM runtime support.*
>
> Thanks for your continued effort on this series.
>
>> Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2=
.6.git
>> Branch: master
>> Commit: c6a389f =A0Linux 3.1-rc4
>
> This series was supposed to be based on my for_3.2/gpio-cleanup branch,
> which removes MOD_REG_BIT among other things.
I saw most of your patches on the mainline except MOD_REG_BIT.
I thought you have no intention of taking it. That's why generated the
series on the mainline.

>
> Please rebase onto that branch so these changes can be tested along with
> changes already queued for v3.2.
Ok.

>
> Thanks,
>
> Kevin
>
