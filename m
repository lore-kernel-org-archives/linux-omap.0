From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [GIT PULL] omap generic wakeirq for v4.2 merge window
Date: Wed, 01 Jul 2015 13:24:33 -0700
Message-ID: <7hh9pnmxry.fsf@deeprootsystems.com>
References: <20150616114645.GA4156@atomide.com>
 <20150629060409.GQ4156@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150629060409.GQ4156@atomide.com> (Tony Lindgren's message of
 "Sun, 28 Jun 2015 23:04:09 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Hi,
>
> * Tony Lindgren <tony@atomide.com> [150616 04:48]:
>> Hi,
>> 
>> Here's a late pull request that would be good to get into v4.2.
>> This series mostly just drops code that's now unnecessary, and
>> also fixes potential interrupt re-entrancy issues that the old
>> handling has.
>> 
>> The series changes omap hsmmc, 8250_omap and omap-serial to use
>> the Linux generic wakeirq. I had to redo the branch last week on
>> recent tty-next branch because of a merge conflict. Other than
>> that, these patches were already in Linux next earlier.
>> 
>> The pull request below also shows the related patches in Rafael's
>> pm-wakeirq branch as I did not create a separate merge commit to
>> base patches on.
>> 
>> This branch depends on both Rafael's pm-wakeirq and Greg's
>> tty-next, so it should be sent separately towards the end of the
>> merge window.
>
> This one is OK to merge now, both pm-wakeirq and tty-next
> dependencies have been merged. This leaves the following
> diffstat for thees changes:

OK, thanks.  I'm collecting a few remaining things for a "late" branch,
but if I miss the merge window, I'll queue it up for -rc2.

Kevin
