From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 21:27:47 +0200
Message-ID: <AANLkTilL90pYVlquvMDAEPHj_AraEi9Qzk-0tTjw9Bkx@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
	<87r5laa4oc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87r5laa4oc.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 6:12 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

>> and #2, the battery lifetime on the N770 and N800 (both of which I have)
>> is **appalling** **bad**.
>
> Appalling bad compared to what?
>
> What's probably more interesting in terms of rough comparisons is
> comparing similar devices with and without opportunistic suspend. =A0The
> Nokia n900 (maemo) and the Moto Droid (android) use the same SoC (TI
> OMAP3) and roughly the same kernel (2.6.2[89], although both are
> heavily patched from mainline.)
>
> The n900 *never* suspends. =A0It only uses dynamic PM + CPUidle.
> The droid uses opportunistic suspend (as well as dynamic PM + CPUidle)
>
> I don't know of any more objective comparison of the two, but as a
> user of both devices I can say that the active usage is basically the
> same (around a day) and the idle use is similar as well, even though
> the Droid has a slightly bigger battery (1400 mAh vs. 1320 mAh.) =A0My
> own usage suggests the n900 is a bit better in idle time, but I have
> not done any measuring or objective tests. =A0I'm guessing the
> difference is probably because the Droid does not use the deepest
> off-mode power states either in idle or suspend (IIRC) where the n900
> does. =A0I suspect that if both were using off-mode and had the same
> battery, these differences would go away.
>
> While this is not really a scientific comparison, it at least gives a
> rough idea. =A0If using opportunistic suspend was adding noticably
> better battery life, I think this would be a different discussion.

Exactly. The point is, opportunistic suspend doesn't in fact add any
value compared to dynamic PM + CPUIdle. It only produces some false
impression that one can handle power management right without using
dynamic PM. And this false impression is the cause for many really
ugly designs (like, for instance, 15 minutes touchscreen inactivity
delay before forcibly shutting down the wireless, as it's done in
stock Android framework).

Thanks,
   Vitaly
