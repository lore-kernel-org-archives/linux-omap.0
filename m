From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Sat, 15 May 2010 12:55:44 -0700
Message-ID: <AANLkTim8OXbnCyrT_9mPGr-5Us4kjf_mUOSHDIHW_LtB@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87aas2azc5.fsf@deeprootsystems.com>
	<AANLkTilsAC--0TGYgeJpNVPzBCFL5uQmeBTjb3SgtjKY@mail.gmail.com>
	<201005152147.22122.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005152147.22122.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Sat, May 15, 2010 at 12:47 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >
>> > Yes, "excruciatingly bad" apps can kill PM on these systems since
>> > anyone can write apps, but the same is true on an opporunistic-suspend
>> > based system since any app could hold a suspend blocker whenever it
>> > wants.
>>
>> No, apps need permission to block suspend.
>
> Are you referring to the fact the permissions of the special device file or
> something different?

The special device file will have filesystem permissions that limit
access to system services.

Arbitrary userspace apps do not have direct access to the device --
they use a service (provided by binder rpc), and the app must declare
its intent (and the user accept this on install) in order to use that
service. The service keeps track of usage stats so if a user
experiences poor battery life they can look at the battery usage thing
and see which apps are keeping the device awake, etc.

Brian
