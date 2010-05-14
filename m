From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 15:18:13 -0700
Message-ID: <AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl> <87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
	<alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@goo>
List-Id: linux-omap@vger.kernel.org

On Fri, May 14, 2010 at 1:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hello,
>
> On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
>
>> No, suspend blockers are mostly used to ensure wakeup events are not
>> ignored, and to ensure tasks triggered by these wakeup events
>> complete.
>
> Standard Linux systems don't need these,

If you don't want to lose wakeup events they do. Standard Linux
systems support suspend, but since they usually don't have a lot of
wakeup events you don't run into a lot of problems.

> because the scheduler just keeps
> the system running as long as there is work to be done.
>

That is only true if you never use suspend.

> Suspend-blocks are only needed because patch 1's opportunistic suspend
> governor tries to suspend the system even when the scheduler indicates
> that there is work to be done. =A0That decision requires all kinds of hac=
ks
> throughout the codebase [1][2].
>
>
> - Paul
>
>
> 1. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
> =A0 May 2010 00:27:56 -0600:
> =A0 http://permalink.gmane.org/gmane.linux.power-management.general/18658
>
> 2. Paul Walmsley E-mail to the linux-pm mailing list, dated Fri, 14
> =A0 May 2010 00:13:50 -0600:
> =A0 http://permalink.gmane.org/gmane.linux.power-management.general/18657
>
>


-- =

Arve Hj=F8nnev=E5g
