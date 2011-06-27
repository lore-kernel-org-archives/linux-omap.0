From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 4/8] OMAP2+: PM: idle clkdms only if already in idle
Date: Mon, 27 Jun 2011 16:36:26 -0700
Message-ID: <4E0913FA.9030607@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
	<1307616853-28395-2-git-send-email-rnayak@ti.com>
	<1307616853-28395-3-git-send-email-rnayak@ti.com>
	<1307616853-28395-4-git-send-email-rnayak@ti.com>
	<1307616853-28395-5-git-send-email-rnayak@ti.com>
	<20110610001556.GA9159@google.com> <4DF1FE6A.3010202@ti.com>
	<alpine.DEB.2.00.1106270012410.460@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1106270012410.460@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, Todd Poynor <toddpoynor@google.com>, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 6/26/2011 11:34 PM, Paul Walmsley wrote:
> Hi Rajendra, Todd,
>
> On Fri, 10 Jun 2011, Rajendra Nayak wrote:
>
>> Paul/Benoit any thoughts on if a per-clkdm lock seems reasonable?
>
> Sounds okay to me.
>
> The experimental patch that you sent didn't add the locking to the *wkdep,
> *sleepdep functions; I guess we'd better add it there at the same time,
> since some of the register access there does a read-modify-write.

My initial idea was to just guard the functions which program the
target clockdomain state, since that's something which had a possibility
of racing.
For the sleepdep/wkupdep programming, I thought they are all done from
within frameworks and during pm-core init at boot and might not run into
concurrency issues. But maybe it makes sense to guard those as well.

>
> It should be possible to get rid of the atomic_t usage in the clockdomain
> code as part of the same series.

Sure, I'll get rid of those.

Thanks,
Rajendra

>
> Todd, thanks for pointing this out.
>
>
> - Paul
